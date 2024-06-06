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

print("Plotting real part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=2)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_pi_stepfunc_revival\\rational_real_revival"
        if !isdir(dir)
            mkpath(dir)
        end

        if timestep == 0
            filename = "$(dir)\\$(Int.(c))_pi_0_1000_00005pi_real.png"
        else
            filename = "$(dir)\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end

print("Plotting real part difference over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=2)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_pi_stepfunc_revival\\rational_real_revival_diff"
        if !isdir(dir)
            mkpath(dir)
        end

        if timestep == 0
            filename = "$(dir)\\$(Int.(c))_pi_0_1000_00005pi_real.png"
        else
            filename = "$(dir)\\$(Int.(c))_pi_$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
        end
        savefig(filename)
    end
end