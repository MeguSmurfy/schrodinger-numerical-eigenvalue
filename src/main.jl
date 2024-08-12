import Pkg
Pkg.add("Plots")

include("./settings.jl")
include("./solution.jl")

using Plots
using .Settings
using .Solution

solReal = Solution.solReal
solImg = Solution.solImg

xPoints = range(0, 2 * pi, step = 0.00005 * pi)

print("Plotting real part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_2.01_intdelta\\rational_real"
        if !isdir(dir)
            mkpath(dir)
        end

        if timestep == 0
            filename = "$(dir)\\0_1000_00005pi_real.png"
        else
            filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end

#=
print("Plotting imaginary part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. solImg(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_2.5_intdelta\\rational_img"
        if !isdir(dir)
            mkpath(dir)
        end

        if timestep == 0
            filename = "$(dir)\\0_1000_00005pi_imaginary.png"
        else
            filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_imaginary.png"
        end
        savefig(filename)
    end
end
=#

print("Plotting real part over irrational points: ")
@time begin
    for timestep in irrationalTimeSteps
        plot(xPoints, (@. solReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_2.01_intdelta\\irrational_real"
        if !isdir(dir)
            mkpath(dir)
        end

        filename = "$(dir)\\$(timestep)_1000_00005pi_real.png"
        savefig(filename)
    end
end

#=
print("Plotting imaginary part over irrational points: ")
@time begin
    for timestep in irrationalTimeSteps
        plot(xPoints, (@. solImg(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_2.5_intdelta\\irrational_img"
        if !isdir(dir)
            mkpath(dir)
        end

        filename = "$(dir)\\$(timestep)_1000_00005pi_imaginary.png"
        savefig(filename)
    end
end
=#