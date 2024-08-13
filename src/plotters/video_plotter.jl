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

xPoints = range(0, 7, step = increment * pi)
steps = 120

dir = DirCreator.createDirectory(1, revival)

for step in range(0, steps)
    print("Plotting real part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\rational_real\\$(@sprintf("%03d", step)).png"
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

        filename = "$(dir)\\rational_real_revival_diff\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end