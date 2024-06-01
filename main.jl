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
pos_eigen_list = [1.5, 2.1, 2.55, 2.8, 2.95]

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

neg_coeff_list = Float64[]
for i in 1:num_neg_eigenvalues
    print("Find negative coefficient $(i): ")
    @time begin
        a = quadgk(x -> neg_eigen_func(x, i) * init_func(x), 0, 2 * pi, rtol = 1e-5)[1]
        b = quadgk(x -> (neg_eigen_func(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(neg_coeff_list, a/b)
    end
end

function neg_sol_real(x, timestep)
    neg_cos_list = map(i -> cos((neg_eigen_list[i])^2 * timestep), range(1, num_neg_eigenvalues, step=1))
    result = 0
    for i in 1:num_neg_eigenvalues
        result += @. neg_coeff_list[i] * neg_cos_list[i] * neg_eigen_func(x, i)
    end
    return result
end

function neg_sol_img(x, timestep)
    neg_sin_list = map(i -> sin((neg_eigen_list[i])^2 * timestep), range(1, num_neg_eigenvalues, step=1))
    result = 0
    for i in 1:num_neg_eigenvalues
        result += @. neg_coeff_list[i] * neg_sin_list[i] * neg_eigen_func(x, i)
    end
    return result
end

# find positive eigenvalues
print("Find positive eigenvalues: ")
@time begin
    pos_determinant(x) = sinh(p * x) * sin((2 * pi - p) * sqrt(c - x^2)) * (2 * x^2 - c) +
                    2 * x * sqrt(c - x^2) * cosh(p * x) * cos((2 * pi - p) * sqrt(c - x^2)) - 
                    2 * x * sqrt(c - x^2)

    for i in 1:10
        global pos_eigen_list = map(x -> newton_iterate(pos_determinant, x), pos_eigen_list)
    end
end

# build solutions for positive eigenvalues
pos_a1 = map(x -> 0.5 * (sqrt(c - x^2) * (cosh(p * x) - sinh(p * x) - cos((2 * pi - p) * sqrt(c - x^2))) - 
                x * sin((2 * pi - p) * sqrt(c - x^2))), pos_eigen_list)
pos_b1 = map(x -> 0.5 * (sqrt(c - x^2) * (-cosh(p * x) - sinh(p * x) + cos((2 * pi - p) * sqrt(c - x^2))) - 
                x * sin((2 * pi - p) * sqrt(c - x^2))), pos_eigen_list)
pos_a2 = map(x -> x * cosh(p * x) * cos(2 * pi * sqrt(c - x^2)) -
                sqrt(c - x^2) * sinh(p * x) * sin(2 * pi * sqrt(c - x^2)) - 
                x * cos(p * sqrt(c - x^2)), pos_eigen_list)
pos_b2 = map(x -> -x * cosh(p * x) * sin(2 * pi * sqrt(c - x^2)) -
                sqrt(c - x^2) * sinh(p * x) * cos(2 * pi * sqrt(c - x^2)) + 
                x * sin(p * sqrt(c - x^2)), pos_eigen_list)

pos_eigen_func1(x, i) = pos_a1[i] * exp(pos_eigen_list[i] * x) + pos_b1[i] * exp(-pos_eigen_list[i] * x)
pos_eigen_func2(x, i) = pos_a2[i] * sin(sqrt(c - (pos_eigen_list[i])^2) * x) + 
                        pos_b2[i] * cos(sqrt(c - (pos_eigen_list[i])^2) * x)
                        
function pos_eigen_func(x, i)
    if x <= p
        return pos_eigen_func1(x, i)
    else
        return pos_eigen_func2(x, i)
    end
end

print("Find positive coefficients: ")
@time begin
    pos_coeff_list = Float64[]
    for i in 1:num_pos_eigenvalues
        a = quadgk(x -> pos_eigen_func(x, i) * init_func(x), 0, 2 * pi, rtol = 1e-5)[1]
        b = quadgk(x -> (pos_eigen_func(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(pos_coeff_list, a/b)
    end
end

function pos_sol_real(x, timestep)
    pos_cos_list = map(i -> cos((pos_eigen_list[i])^2 * timestep), range(1, num_pos_eigenvalues, step=1))
    result = 0
    for i in 1:num_pos_eigenvalues
        result += @. pos_coeff_list[i] * pos_cos_list[i] * pos_eigen_func(x, i)
    end
    return result
end

function pos_sol_img(x, timestep)
    pos_sin_list = map(i -> -sin((pos_eigen_list[i])^2 * timestep), range(1, num_pos_eigenvalues, step=1))
    result = 0
    for i in 1:num_pos_eigenvalues
        result += @. pos_coeff_list[i] * pos_sin_list[i] * pos_eigen_func(x, i)
    end
    return result
end

#=
x_points = range(0, 2 * pi, step = 0.00005 * pi)
plot(x_points, (@. pos_eigen_func(x_points, 1)), linecolor=:darkblue, linewidth=2)
plot!(grid=false, legend=false, size=(900, 600))
=#

# build solutions for zero eigenvalue
zero_a1 = sqrt(c) * (cos((2 * pi - p) * sqrt(c)) - 1)
zero_b1 = p * sqrt(c) + sin((2 * pi - p) * sqrt(c))
zero_a2 = p * sqrt(c) * sin(2 * pi * sqrt(c)) - cos(2 * pi * sqrt(c)) + cos(p * sqrt(c))
zero_b2 = p * sqrt(c) * cos(2 * pi * sqrt(c)) + sin(2 * pi * sqrt(c)) - sin(p * sqrt(c))

function zero_eigen_func(x)
    if x <= p
        return zero_a1 * x + zero_b1
    else
        return zero_a2 * sin(sqrt(c) * x) + zero_b2 * cos(sqrt(c) * x)
    end
end

zero_coeff = quadgk(x -> zero_eigen_func(x) * init_func(x), 0, 2 * pi, rtol = 1e-5)[1] / 
                quadgk(x -> (zero_eigen_func(x))^2, 0, 2 * pi, rtol = 1e-5)[1]

function zero_sol(x)
    if ((2 - 2 * cos((2 * pi - p) * sqrt(c)) + p * sqrt(c) * sin((2 * pi - p) * sqrt(c))) <= 1e-10)
        result = @. zero_coeff * zero_eigen_func(x)
    else
        result = 0
    end
    return result
end

println(zero_sol(1))

#=
println(length(neg_eigen_list))
println(neg_eigen_list)
println(length(pos_eigen_list))
println(pos_eigen_list)
=#

# plot
print("Plotting real part over rational points: ")
@time begin
    x_points = range(0, 2 * pi, step = 0.00005 * pi)
    for timestep in time_steps
        # make the plot
        plot(x_points, (@. neg_sol_real(x_points, timestep) + pos_sol_real(x_points, timestep) + zero_sol(x_points)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        if timestep == 0
            filename = "images\\9_pi3_stepfunc\\rational_real\\9_pi3_0_1000_00005pi_real.png"
        else
            filename = "images\\9_pi3_stepfunc\\rational_real\\9_pi3_pi$(pi/timestep)_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end

print("Plotting imaginary part over rational points: ")
@time begin
    for timestep in time_steps
        # make the plot
        plot(x_points, (@. neg_sol_img(x_points, timestep) + pos_sol_img(x_points, timestep)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        if timestep == 0
            filename = "images\\9_pi3_stepfunc\\rational_img\\9_pi3_0_1000_00005pi_imaginary.png"
        else
            filename = "images\\9_pi3_stepfunc\\rational_img\\9_pi3_pi$(pi/timestep)_1000_00005pi_imaginary.png"
        end
        savefig(filename)
    end
end

print("Plotting real part over irrational points: ")
@time begin
    for timestep in irrational_time_steps
        # make the plot
        plot(x_points, (@. neg_sol_real(x_points, timestep) + pos_sol_real(x_points, timestep) + zero_sol(x_points)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        filename = "images\\9_pi3_stepfunc\\irrational_real\\9_pi3_$(timestep)_1000_00005pi_real.png"
        savefig(filename)
    end
end

print("Plotting imaginary part over irrational points: ")
@time begin
    for timestep in irrational_time_steps
        # make the plot
        plot(x_points, (@. neg_sol_img(x_points, timestep) + pos_sol_img(x_points, timestep)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        filename = "images\\9_pi3_stepfunc\\irrational_img\\9_pi3_$(timestep)_1000_00005pi_imaginary.png"
        savefig(filename)
    end
end