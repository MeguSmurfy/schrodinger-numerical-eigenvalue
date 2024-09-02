import Pkg
Pkg.add("Plots")
Pkg.add("Printf")

include("../config/configParser.jl")
include("../utils/dirCreator.jl")
include("../solutions/solution.jl")

using Plots
using Printf
using .ConfigParser
using .Solution
using .DirCreator

increment = ConfigParser.increment
revival = ConfigParser.revival

solReal = Solution.solReal
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 2 * pi, step = increment * pi)
steps = 120

dir = DirCreator.createDirectory(1, revival)

#=
for step in range(0, steps)
    print("Plotting real part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\rational_real_solution\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end

for step in range(0, steps)
    print("Plotting standard revival part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\rational_real_revival\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end

for step in range(0, steps)
    print("Plotting continuous part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\rational_real_continuous\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end
=#

for step in range(0, steps)
    filtered = filter(x -> (x - floor(x * steps / pi) * pi / steps > 1e-10), xPoints)
    print("Plotting adjusted standard revival part over rational point $(step): ")
    @time begin
        timestep = step // steps
        slope = (revivalSolReal(0.002, timestep) - revivalSolReal(0.001, timestep)) / 0.001

        plot(filtered, (@. revivalSolReal(filtered, timestep) - revivalSolReal(floor(filtered * steps / pi) * pi / steps + 0.001, timestep) + slope * (floor(filtered * steps / pi) * pi / steps + 0.001 - pi)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\standard_revival_adjusted\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end