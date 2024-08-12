module ConfigParser

include("./config.jl")
include("./initFunc.jl")

using .Config
using .InitFunc

export c, p, rationalTimeSteps, irrationalTimeSteps, numNegEigenvalues, numPosEigenvalues, initFunc, initFunc2, initFunc3

increment = Config.increment

mode = Config.mode
revival = Config.revival

c = Config.c

p = Config.p
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

initFunc = InitFunc.initFunc
initFunc2 = InitFunc.initFunc2
initFunc3 = InitFunc.initFunc3

end