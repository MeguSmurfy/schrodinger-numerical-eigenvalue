module Config

# plotting constants
increment = 0.0005

# revival mode
revival = false

# initial function designator
initDesignator = "intdelta"

# c is the step size of the potential function (integers)
c = 9

# p is the position of potential discontinuity
# p_mode = 0 for rational, p_mode = 1 for irrational
pMode = 1
p = 0.05

# timesteps for plotting
rationalTimeSteps = [0, 1, 1 // 2, 1 // 3, 1 // 4, 1 // 5, 1 // 6, 1 // 7, 1 // 8, 1 // 9, 1 // 10, 2 // 15, 1 // 15, 1 // 30]
irrationalTimeSteps = [0.0001, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5]

# initializers for negative eigenvalues
numNegEigenvalues = 1000
numNegEigenvaluesPicked = 4
negEigenList = [0.016, 0.378, 2.645, 2.673]
startPos = 5
variator = 0.1

# initializers for positive eigenvalues
numPosEigenvalues = 5
posEigenList = [2.204, 2.236, 2.804, 2.828, 2.99]

end