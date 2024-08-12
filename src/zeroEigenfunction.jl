module ZeroEigenfunction

include("./config/config.jl")

using .Config

export zeroEigenFunc

a1 = sqrt(c) * (cos((2 * pi - p) * sqrt(c)) - 1)
b1 = p * sqrt(c) + sin((2 * pi - p) * sqrt(c))
a2 = p * sqrt(c) * sin(2 * pi * sqrt(c)) - cos(2 * pi * sqrt(c)) + cos(p * sqrt(c))
b2 = p * sqrt(c) * cos(2 * pi * sqrt(c)) + sin(2 * pi * sqrt(c)) - sin(p * sqrt(c))

function zeroEigenFunc(x)
    if x <= p
        return a1 * x + b1
    else
        return a2 * sin(sqrt(c) * x) + b2 * cos(sqrt(c) * x)
    end
end

end