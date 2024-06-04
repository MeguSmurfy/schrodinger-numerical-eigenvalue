module PosEigenfunction

include("./settings.jl")
include("./eigenvalues.jl")

using .Settings
using .Eigenvalues: posEigenList

export posEigenFunc

el = posEigenList

a1 = map(x -> 0.5 * (sqrt(c - x^2) * (cosh(p * x) - sinh(p * x) - cos((2 * pi - p) * sqrt(c - x^2))) - 
                x * sin((2 * pi - p) * sqrt(c - x^2))), el)
b1 = map(x -> 0.5 * (sqrt(c - x^2) * (-cosh(p * x) - sinh(p * x) + cos((2 * pi - p) * sqrt(c - x^2))) - 
                x * sin((2 * pi - p) * sqrt(c - x^2))), el)
a2 = map(x -> x * cosh(p * x) * cos(2 * pi * sqrt(c - x^2)) -
                sqrt(c - x^2) * sinh(p * x) * sin(2 * pi * sqrt(c - x^2)) - 
                x * cos(p * sqrt(c - x^2)), el)
b2 = map(x -> -x * cosh(p * x) * sin(2 * pi * sqrt(c - x^2)) -
                sqrt(c - x^2) * sinh(p * x) * cos(2 * pi * sqrt(c - x^2)) + 
                x * sin(p * sqrt(c - x^2)), el)

posEigenFunc1(x, i) = a1[i] * exp(el[i] * x) + b1[i] * exp(-el[i] * x)
posEigenFunc2(x, i) = a2[i] * sin(sqrt(c - (el[i])^2) * x) + b2[i] * cos(sqrt(c - (el[i])^2) * x)
                        
function posEigenFunc(x, i)
    if x <= p
        return posEigenFunc1(x, i)
    else
        return posEigenFunc2(x, i)
    end
end

end