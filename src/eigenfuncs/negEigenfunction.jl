module NegEigenfunction

include("../config/config.jl")
include("./eigenvalues.jl")

using .Config
using .Eigenvalues: negEigenList

export negEigenFunc

el = negEigenList

a1 = map(x -> sqrt(c + x^2) * (cos(p * x) - cos((2 * pi - p) * sqrt(c + x^2))), el)
b1 = map(x -> -(x * sin((2 * pi - p) * sqrt(c + x^2)) + sqrt(c + x^2) * sin(p * x)), el)
a2 = map(x -> x * cos(p * x) * cos(2 * pi * sqrt(c + x^2)) - 
                    sqrt(c + x^2) * sin(p * x) * sin(2 * pi * sqrt(c + x^2)) - 
                    x * cos(p * sqrt(c + x^2)), el)
b2 = map(x -> -(x * cos(p * x) * sin(2 * pi * sqrt(c + x^2)) + 
                    sqrt(c + x^2) * sin(p * x) * cos(2 * pi * sqrt(c + x^2)) - 
                    x * sin(p * sqrt(c + x^2))), el)

negEigenFunc1(x, i) = a1[i] * sin(el[i] * x) + b1[i] * cos(el[i] * x)
negEigenFunc2(x, i) = a2[i] * sin(sqrt(c + (el[i])^2) * x) + 
                        b2[i] * cos(sqrt(c + (el[i])^2) * x)
                        
function negEigenFunc(x, i)
    if x <= p
        return negEigenFunc1(x, i)
    else
        return negEigenFunc2(x, i)
    end
end

end