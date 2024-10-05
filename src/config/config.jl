module Config

# plotting constants
increment = 0.002

# revival mode
revival = true

# initial function designator
initDesignator = "intdelta"

# c is the step size of the potential function (integers)
c = 9

# p is the position of potential discontinuity
# p_mode = 0 for rational, p_mode = 1 for irrational
pMode = 0
p = 1 // 9

# timesteps for plotting
rationalTimeSteps = [0, 1, 1 // 2, 1 // 3, 1 // 4, 1 // 5, 1 // 6, 1 // 7, 1 // 8, 1 // 9, 1 // 10, 2 // 15, 1 // 15, 1 // 30]
irrationalTimeSteps = [0.0001, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5]

# initializers for negative eigenvalues
numNegEigenvalues = 1000
numNegEigenvaluesPicked = 4
negEigenList = [0.28155, 0.98692, 2.67133, 2.81913]
startPos = 5
variator = 0.1

# initializers for positive eigenvalues
numPosEigenvalues = 5
posEigenList = [2.01956, 2.22797, 2.7, 2.82681, 2.96903]

end