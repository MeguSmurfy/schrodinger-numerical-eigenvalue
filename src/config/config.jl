module Config

# plotting constants
increment = 0.0005

# mode = 0 for images, mode = 1 for videos
mode = 0

# revival mode
revival = true

# initial function designator
initDesignator = "intdelta"

# c is the step size of the potential function (integers)
c = 9

# p is the position of potential discontinuity
# p_mode = 0 for rational, p_mode = 1 for irrational
pMode = 0
p = 1 // 2

# timesteps for plotting
rationalTimeSteps = [0, 1, 1 // 2, 1 // 3, 1 // 4, 1 // 5, 1 // 6, 1 // 7, 1 // 8, 1 // 9, 1 // 10, 2 // 15, 1 // 15, 1 // 30]
irrationalTimeSteps = [0.0001, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5]

# initializers for negative eigenvalues
numNegEigenvalues = 1000
numNegEigenvaluesPicked = 4
negEigenList = [1.59, 1.76, 3.02, 3.16]

# initializers for negative eigenvalues
numPosEigenvalues = 5
posEigenList = [1.1, 1.9, 2.45, 2.76, 2.94]

end