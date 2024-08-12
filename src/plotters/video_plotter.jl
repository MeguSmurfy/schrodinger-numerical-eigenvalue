import Pkg
Pkg.add("Plots")
Pkg.add("Printf")

include("../config/configParser.jl")
include("../solutions/solution.jl")

using Plots
using Printf
using .ConfigParser
using .Solution

increment = ConfigParser.increment
revival = ConfigParser.revival

solReal = Solution.solReal
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 7, step = increment * pi)
steps = 120

dir = DirCreator.createDirectory(1, revival)

for step in range(0, steps)
    print("Plotting continuous part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "$(dir)\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end