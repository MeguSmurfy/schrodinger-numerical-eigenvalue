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
p = pi/2
num_neg_eigenvalues = 1000

neg_determinant(x) = sin(p * x) * sin((2 * pi - p) * sqrt(c + x^2)) * (2 * x^2 + c) - 
        2 * x * sqrt(c + x^2) * cos(p * x) * cos((2 * pi - p) * sqrt(c + x^2)) + 
        2 * x * sqrt(c + x^2)

x_points = range(0, 20, length = 1000)
plot(x_points, @. neg_determinant(x_points))

neg_eigen_list = [0.5, 1., 2., 2.5, 3.25, 3.5]

for i in 5:(num_neg_eigenvalues / 2 + 1)
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - 0.1
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + 0.1
    append!(neg_eigen_list, [lower, higher])
end

for i in 1:10
    global neg_eigen_list = map(x -> newton_iterate(neg_determinant, x), neg_eigen_list)
end

print(neg_eigen_list)