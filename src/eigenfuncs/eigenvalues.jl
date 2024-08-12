module Eigenvalues

include("../utils/utils.jl")
include("../config/config.jl")

using .Utils
using .Config

export negEigenList, posEigenList, zeroEigenvalue

negEigenList = Config.negEigenList
posEigenList = Config.posEigenList
zeroEigenvalue = false

negDeterminant(x) = sin(p * x) * sin((2 * pi - p) * sqrt(c + x^2)) * (2 * x^2 + c) - 
        2 * x * sqrt(c + x^2) * cos(p * x) * cos((2 * pi - p) * sqrt(c + x^2)) + 
        2 * x * sqrt(c + x^2)

negEigenList = Utils.newtonMethod(negDeterminant, negEigenList)

posDeterminant(x) = sinh(p * x) * sin((2 * pi - p) * sqrt(c - x^2)) * (2 * x^2 - c) +
                    2 * x * sqrt(c - x^2) * cosh(p * x) * cos((2 * pi - p) * sqrt(c - x^2)) - 
                    2 * x * sqrt(c - x^2)

posEigenList = Utils.newtonMethod(posDeterminant, posEigenList)

if (abs(2 - 2 * cos((2 * pi - p) * sqrt(c)) + p * sqrt(c) * sin((2 * pi - p) * sqrt(c))) <= 1e-10)
    zeroEigenvalue = true
end

end