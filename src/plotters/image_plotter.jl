import Pkg
Pkg.add("Plots")

include("../config/configParser.jl")
include("../utils/dirCreator.jl")
include("../solutions/solution.jl")

using Plots
using .ConfigParser
using .Solution
using .DirCreator

numNegEigenvalues = ConfigParser.numNegEigenvalues
increment = ConfigParser.increment
revival = ConfigParser.revival

solReal = Solution.solReal
solImg = Solution.solImg
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 7, step = increment * pi)
dir = DirCreator.createDirectory(0, revival)

if !revival
    print("Plotting real part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            if timestep == 0
                filename = "$(dir)\\rational_real\\0.png"
            else
                filename = "$(dir)\\rational_real\\$(numerator(timestep))pi$(denominator(timestep)).png"
            end
            savefig(filename)
        end
    end

    print("Plotting imaginary part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solImg(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            if timestep == 0
                filename = "$(dir)\\rational_img\\0.png"
            else
                filename = "$(dir)\\rational_img\\$(numerator(timestep))pi$(denominator(timestep)).png"
            end
            savefig(filename)
        end
    end

    print("Plotting real part over irrational points: ")
    @time begin
        for timestep in irrationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            filename = "$(dir)\\irrational_real\\$(timestep).png"
            savefig(filename)
        end
    end

    print("Plotting imaginary part over irrational points: ")
    @time begin
        for timestep in irrationalTimeSteps
            plot(xPoints, (@. solImg(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))
        
            filename = "$(dir)\\irrational_img\\$(timestep).png"
            savefig(filename)
        end
    end

else
    print("Plotting standard revival part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            if timestep == 0
                filename = "$(dir)\\rational_real_revival\\0.png"
            else
                filename = "$(dir)\\rational_real_revival\\$(numerator(timestep))pi$(denominator(timestep)).png"
            end
            savefig(filename)
        end
    end

    print("Plotting continuous part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            if timestep == 0
                filename = "$(dir)\\rational_real_revival_diff\\0.png"
            else
                filename = "$(dir)\\rational_real_revival_diff\\$(numerator(timestep))pi$(denominator(timestep)).png"
            end
            savefig(filename)
        end
    end
end