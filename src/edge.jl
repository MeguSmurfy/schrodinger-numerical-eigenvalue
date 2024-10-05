import Pkg
Pkg.add("Plots")
Pkg.add("Printf")

using Plots
using Printf

c = 9
p = 0
increment = 0.0005

function initFunc3(x)
    jump = pi
    if x <= jump - 2 * pi
        return -x / (2 * pi) - 1
    elseif x <= jump
        return -x / (2 * pi)
    elseif x <= jump + 2 * pi
        return -x / (2 * pi) + 1
    else 
        return -x / (2 * pi) + 2
    end
end

function revivalSolReal(x, timestepFractionOfPi)
    q = denominator(timestepFractionOfPi // 2)
    vAverage = c * (2 * pi - p) / (2 * pi)
    result = 0
    for m in 0:(q-1)
        for k in 0:(q-1)
            result += @. cos(m * 2 * pi * k / q - m^2 * pi * timestepFractionOfPi + pi * timestepFractionOfPi * vAverage) * initFunc3(x - 2 * pi * k / q)
        end
    end
    result = result / q
    return result
end

xPoints = range(0, 2 * pi, step = increment * pi)
steps = 120

for step in range(0, steps)
    print("Plotting standard revival part over rational point $(step): ")
    @time begin
        timestep = step // steps
        plot(xPoints, (@. revivalSolReal(xPoints, timestep)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "videos\\9_0_intdelta_1000_0.0005pi_revival\\rational_real_revival\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end

for step in range(0, steps)
    filtered = filter(x -> (x - floor(x * steps / pi) * pi / steps > 1e-10), xPoints)
    print("Plotting adjusted standard revival part over rational point $(step): ")
    @time begin
        timestep = step // steps
        slope = (revivalSolReal(0.002, timestep) - revivalSolReal(0.001, timestep)) / 0.001

        plot(filtered, (@. revivalSolReal(filtered, timestep) - revivalSolReal(floor(filtered * steps / pi) * pi / steps + 0.001, timestep) + slope * (floor(filtered * steps / pi) * pi / steps + 0.001 - pi)), linecolor=:darkblue, linewidth=1, ylims=(-1, 1))
        plot!(grid=false, legend=false, size=(900, 600))

        filename = "videos\\9_0_intdelta_1000_0.0005pi_revival\\standard_revival_adjusted\\$(@sprintf("%03d", step)).png"
        savefig(filename)
    end
end