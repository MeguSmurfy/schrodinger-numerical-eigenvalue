import Pkg
Pkg.add("Plots")

include("./settings.jl")
include("./solution.jl")

using Plots
using .Settings
using .Solution

solReal = Solution.solReal
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 2 * pi, step = 0.00005 * pi)

#=
print("Plotting real part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        # make the plot
        plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=2)

        # customization
        plot!(grid=false, legend=false, size=(900, 600))

        # save file
        if timestep == 0
            filename = "images\\$(Int.(c))_pi_stepfuncpi2_test\\rational_real\\$(Int.(c))_pi_0_1000_00005pi_real.png"
        else
            filename = "images\\$(Int.(c))_pi_stepfuncpi2_test\\rational_real\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end
=#

timestep = 0

plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=2)
plot!(grid=false, legend=false, size=(900, 600))
if timestep == 0
    filename = "images\\$(Int.(c))_pi_stepfuncpi2_test\\rational_real_diff\\$(Int.(c))_pi_0_1000_00005pi_real.png"
else
    filename = "images\\$(Int.(c))_pi_stepfuncpi2_test\\rational_real_diff\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
end
savefig(filename)