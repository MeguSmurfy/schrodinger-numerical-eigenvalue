module NegEigenvaluesInitializer

include("../config/configParser.jl")

using .ConfigParser

negEigenList = Config.negEigenList
picked = Config.numNegEigenvaluesPicked

startPos = 5
variator = 0.1
endPos = cld(numNegEigenvalues, 2) + start - fld(picked, 2)

for i in startPos:endPos
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - variator
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + variator
    append!(negEigenList, [lower, higher])
end

negEigenList = negEigenList[1:numNegEigenvalues]

end