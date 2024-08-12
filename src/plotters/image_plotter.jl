import Pkg
Pkg.add("Plots")

include("../config/configParser.jl")
include("../utils/dirCreator.jl")
include("../solutions/solution.jl")

using Plots
using .ConfigParser
using .Solution
using .DirCreator

revival = Config.revival

solReal = Solution.solReal
solImg = Solution.solImg
revivalSolReal = Solution.revivalSolReal

xPoints = range(0, 7, step = 0.0005 * pi)
dir = DirCreator.createDirectory()

if revival
    print("Plotting real part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_2.01_intdelta\\rational_real"

            if timestep == 0
                filename = "$(dir)\\0_1000_00005pi_real.png"
            else
                filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
            end
            savefig(filename)
        end
    end

    print("Plotting imaginary part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solImg(xPoints, timestep * pi)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_2.5_intdelta\\rational_img"

            if timestep == 0
                filename = "$(dir)\\0_1000_00005pi_imaginary.png"
            else
                filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_imaginary.png"
            end
            savefig(filename)
        end
    end

    print("Plotting real part over irrational points: ")
    @time begin
        for timestep in irrationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_2.01_intdelta\\irrational_real"

            filename = "$(dir)\\$(timestep)_1000_00005pi_real.png"
            savefig(filename)
        end
    end

    print("Plotting imaginary part over irrational points: ")
    @time begin
        for timestep in irrationalTimeSteps
            plot(xPoints, (@. solImg(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_2.5_intdelta\\irrational_img"
        
            filename = "$(dir)\\$(timestep)_1000_00005pi_imaginary.png"
            savefig(filename)
        end
    end

else
    print("Plotting standard revival part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_pi2_intdelta_revival\\rational_real_revival"

            if timestep == 0
                filename = "$(dir)\\0_1000_00005pi_real.png"
            else
                filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
            end
            savefig(filename)
        end
    end

    print("Plotting continuous part over rational points: ")
    @time begin
        for timestep in rationalTimeSteps
            plot(xPoints, (@. solReal(xPoints, timestep * pi) - revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1)
            plot!(grid=false, legend=false, size=(900, 600))

            dir = "images\\$(Int.(c))_pi2_intdelta_revival\\rational_real_revival_diff"

            if timestep == 0
                filename = "$(dir)\\0_1000_00005pi_real.png"
            else
                filename = "$(dir)\\$(numerator(timestep))pi$(denominator(timestep))_1000_00005pi_real.png"
            end
            savefig(filename)
        end
    end
end