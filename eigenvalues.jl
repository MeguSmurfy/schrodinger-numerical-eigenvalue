module Eigenvalues

include("./utils.jl")
include("./settings.jl")

using .Utils
using .Settings

export negEigenList, posEigenList, zeroEigenvalue

negEigenList = Settings.negEigenList
posEigenList = Settings.posEigenList
zeroEigenvalue = false

print("Find negative eigenvalues: ")
@time begin
    negDeterminant(x) = sin(p * x) * sin((2 * pi - p) * sqrt(c + x^2)) * (2 * x^2 + c) - 
        2 * x * sqrt(c + x^2) * cos(p * x) * cos((2 * pi - p) * sqrt(c + x^2)) + 
        2 * x * sqrt(c + x^2)

    for i in 1:10
        global negEigenList = map(x -> Utils.newtonIterate(negDeterminant, x), negEigenList)
    end
end

# find positive eigenvalues
print("Find positive eigenvalues: ")
@time begin
    posDeterminant(x) = sinh(p * x) * sin((2 * pi - p) * sqrt(c - x^2)) * (2 * x^2 - c) +
                    2 * x * sqrt(c - x^2) * cosh(p * x) * cos((2 * pi - p) * sqrt(c - x^2)) - 
                    2 * x * sqrt(c - x^2)

    for i in 1:10
        global posEigenList = map(x -> Utils.newtonIterate(posDeterminant, x), posEigenList)
    end
end

# determine zero eigenvalue
if ((2 - 2 * cos((2 * pi - p) * sqrt(c)) + p * sqrt(c) * sin((2 * pi - p) * sqrt(c))) <= 1e-10)
    zeroEigenvalue = true
end

end