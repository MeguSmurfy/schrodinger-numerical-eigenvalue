module NegEigenvaluesInitializer

include("../config/configParser.jl")

using .ConfigParser

negEigenList = ConfigParser.negEigenList
picked = ConfigParser.numNegEigenvaluesPicked
startPos = ConfigParser.startPos
variator = ConfigParser.variator

endPos = cld(numNegEigenvalues, 2) + startPos - fld(picked, 2)

for i in startPos:endPos
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - variator
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + variator
    append!(negEigenList, [lower, higher])
end

negEigenList = negEigenList[1:numNegEigenvalues]

end