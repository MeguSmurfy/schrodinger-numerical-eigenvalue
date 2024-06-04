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
        # make the plot
        plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        if timestep == 0
            filename = "images\\$(Int.(c))_pi_stepfuncpi2\\rational_real\\$(Int.(c))_pi_0_1000_00005pi_real.png"
        else
            filename = "images\\$(Int.(c))_pi_stepfuncpi2\\rational_real\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end

print("Plotting imaginary part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        # make the plot
        plot(xPoints, (@. solImg(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        if timestep == 0
            filename = "images\\$(Int.(c))_pi_stepfuncpi2\\rational_img\\$(Int.(c))_pi_0_1000_00005pi_imaginary.png"
        else
            filename = "images\\$(Int.(c))_pi_stepfuncpi2\\rational_img\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_imaginary.png"
        end
        savefig(filename)
    end
end

print("Plotting real part over irrational points: ")
@time begin
    for timestep in irrationalTimeSteps
        # make the plot
        plot(xPoints, (@. solReal(xPoints, timestep)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        filename = "images\\$(Int.(c))_pi_stepfuncpi2\\irrational_real\\$(Int.(c))_pi_$(timestep)_1000_00005pi_real.png"
        savefig(filename)
    end
end

print("Plotting imaginary part over irrational points: ")
@time begin
    for timestep in irrationalTimeSteps
        # make the plot
        plot(xPoints, (@. solImg(xPoints, timestep)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        filename = "images\\$(Int.(c))_pi_stepfuncpi2\\irrational_img\\$(Int.(c))_pi_$(timestep)_1000_00005pi_imaginary.png"
        savefig(filename)
    end
end