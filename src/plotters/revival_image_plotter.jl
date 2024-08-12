import Pkg
Pkg.add("Plots")

include("../config/config.jl")
include("../solutions/solution.jl")

using Plots
using .Config
using .Solution

solReal = Solution.solReal
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 7, step = 0.00005 * pi)

print("Plotting real part over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_pi2_intdelta_revival\\rational_real_revival"
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

print("Plotting real part difference over rational points: ")
@time begin
    for timestep in rationalTimeSteps
        plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
        plot!(grid=false, legend=false, size=(900, 600))

        dir = "images\\$(Int.(c))_pi2_intdelta_revival\\rational_real_revival_diff"
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