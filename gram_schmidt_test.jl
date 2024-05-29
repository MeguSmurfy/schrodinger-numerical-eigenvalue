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
c = 9
p = pi / 3
time_steps = [0, pi, pi / 2, pi / 3, pi / 4, pi / 5, pi / 6, pi / 7, pi / 8, pi / 9, pi / 10, 2 * pi / 15, pi / 15, pi / 30]
irrational_time_steps = [0.0001, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5]

num_neg_eigenvalues = 1000
neg_eigen_list = [1., 1.6, 2.95, 2.96]
for i in 5:(num_neg_eigenvalues / 2 + 2)
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - 0.1
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + 0.1
    append!(neg_eigen_list, [lower, higher])
end

num_pos_eigenvalues = 5
pos_eigen_list = [1.5, 2.1, 2.5, 2.8, 2.95]

function init_func(x)
    if x <= pi
        return 0
    else
        return 1
    end
end

init_func2(x) = 1 - (1 + exp(-2 * 100 * x))^(-1) + (1 + exp(-2 * 100 * (x - pi)))^(-1) - (1 + exp(-2 * 100 * (x- 2 * pi)))^(-1)

# find negative eigenvalues
print("Find negative eigenvalues: ")
@time begin    
    neg_determinant(x) = sin(p * x) * sin((2 * pi - p) * sqrt(c + x^2)) * (2 * x^2 + c) - 
        2 * x * sqrt(c + x^2) * cos(p * x) * cos((2 * pi - p) * sqrt(c + x^2)) + 
        2 * x * sqrt(c + x^2)

    for i in 1:10
        global neg_eigen_list = map(x -> newton_iterate(neg_determinant, x), neg_eigen_list)
    end
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

num_fails = 0
for i in 1:div(num_neg_eigenvalues, 2)
    result = quadgk(x -> neg_eigen_func(x, 2*i-1) * neg_eigen_func(x, 2*i), 0, 2 * pi, rtol = 1e-5)[1] / 
            sqrt(quadgk(x -> (neg_eigen_func(x, 2*i-1))^2, 0, 2 * pi, rtol = 1e-5)[1] * 
            quadgk(x -> (neg_eigen_func(x, 2*i))^2, 0, 2 * pi, rtol = 1e-5)[1])
    if result >= 1e-2
        println("Pair ($(2*i-1), $(2*i)) fails with result $result.")
        global num_fails += 1
    else
        println("Pair ($(2*i-1), $(2*i)) passes with result $result.")
    end
end

