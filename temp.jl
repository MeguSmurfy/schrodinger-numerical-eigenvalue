# import packages
import Pkg
Pkg.add("Plots")
Pkg.add("SymPy")
Pkg.add("CalculusWithJulia")
Pkg.add("QuadGK")

# declare packages
using CalculusWithJulia
using Plots
using SymPy
using QuadGK

# Newton's method function
function newton_iterate(f::Function, x)
    return x - f(x) * D(f)(x) / ((D(f)(x))^2 - f(x) * D(f, 2)(x))
end

# define constants
num_neg_eigenvalues = 40
c = 9
p = pi
function init_func(x)
    if x <= p
        return 0
    else
        return 1
    end
end

# find negative eigenvalues
neg_eigen_list = [0.5, 1., 2., 2.5, 3.25, 3.5]

for i in 5:(num_neg_eigenvalues / 2 + 1)
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - 0.1
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + 0.1
    append!(neg_eigen_list, [lower, higher])
end

neg_determinant(x) = sin(p * x) * sin((2 * pi - p) * sqrt(c + x^2)) * (2 * x^2 + c) - 
    2 * x * sqrt(c + x^2) * cos(p * x) * cos((2 * pi - p) * sqrt(c + x^2)) + 
    2 * x * sqrt(c + x^2)

for i in 1:10
    global neg_eigen_list = map(x -> newton_iterate(neg_determinant, x), neg_eigen_list)
end

# build solutions for negative eigenvalues
neg_a1 = map(x -> sqrt(c + x^2) * (cos(p * x) - cos((2 * pi - p) * sqrt(c + x^2))), neg_eigen_list)
neg_b1 = map(x -> -(x * sin((2 * pi - p) * sqrt(c + x^2)) + sqrt(c + x^2) * sin(p * x)), neg_eigen_list)
neg_a2 = map(x -> x * cos(p * x) * cos(2 * pi * sqrt(c + x^2)) - 
                    sqrt(c + x^2) * sin(p * x) * sin(2 * pi * sqrt(c + x^2)) - 
                    x * cos(p * sqrt(c + x^2)), neg_eigen_list)
neg_b2 = map(x -> -(x * cos(p * x) * sin(2 * pi * sqrt(c + x^2)) + 
                    sqrt(c + x^2) * sin(p * x) * cos(2 * pi * sqrt(c + x^2)) - 
                    x * sin(p * sqrt(c + x^2))), neg_eigen_list)

neg_eigen_func1(x, i) = neg_a1[i] * sin(neg_eigen_list[i] * x) + neg_b1[i] * cos(neg_eigen_list[i] * x)
neg_eigen_func2(x, i) = neg_a2[i] * sin(sqrt(c + (neg_eigen_list[i])^2) * x) + 
                        neg_b2[i] * cos(sqrt(c + (neg_eigen_list[i])^2) * x)
                        
function neg_eigen_func(x, i)
    if x <= p
        return neg_eigen_func1(x, i)
    else
        return neg_eigen_func2(x, i)
    end
end

neg_coeff_list = Float64[]
for i in 1:num_neg_eigenvalues
    a = quadgk(x -> neg_eigen_func(x, i) * init_func(x), 0, 2 * pi, rtol = 1e-8)[1]
    b = quadgk(x -> (neg_eigen_func(x, i))^2, 0, 2 * pi, rtol = 1e-8)[1]
    push!(neg_coeff_list, a/b)
end

function neg_sol(x)
    result = 0
    for i in 1:num_neg_eigenvalues
        result += @. neg_coeff_list[i] * neg_eigen_func(x, i)
    end
    return result
end

# plot
x_points = range(0, 2 * pi, length = 1000)
plot(x_points, @. neg_sol(x_points))