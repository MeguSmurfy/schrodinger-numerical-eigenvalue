module ConfigParser

include("./config.jl")

using .Config

export c, p, rationalTimeSteps, irrationalTimeSteps, numNegEigenvalues, numPosEigenvalues, initFunc, initFunc2, initFunc3

mode = Config.mode
revival = Config.revival

pMode = Config.pMode
if pMode == 0
    p = p * pi
end

rationalTimeSteps = Config.rationalTimeSteps
irrationalTimeSteps = Config.irrationalTimeSteps

numNegEigenvalues = Config.numNegEigenvalues
numNegEigenvaluesPicked = Config.numNegEigenvaluesPicked
negEigenList = Config.negEigenList

numPosEigenvalues = Config.numPosEigenvalues
posEigenList = Config.posEigenList

initDesignator = Config.initDesignator

initFunc = Config.initFunc
initFunc2 = Config.initFunc2
initFunc3 = Config.initFunc3

end