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

pos_determinant(x) = sinh(p * x) * sin((2 * pi - p) * sqrt(c - x^2)) * (2 * x^2 - c) +
                    2 * x * sqrt(c - x^2) * cosh(p * x) * cos((2 * pi - p) * sqrt(c - x^2)) - 
                    2 * x * sqrt(c - x^2)

x_points = range(0, 3, length = 1000)
plot(x_points, (@. pos_determinant(x_points)), linecolor=:darkblue, linewidth=3)
plot!(legend=false, grid=false, framestyle=:origin, size=(900, 600))

#=
pos_eigen_list = [1., 2., 2.5, 2.7, 2.9]

for i in 1:10
    global pos_eigen_list = map(x -> newton_iterate(pos_determinant, x), pos_eigen_list)
end

print(pos_eigen_list)
=#