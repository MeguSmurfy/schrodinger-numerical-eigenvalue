module Settings

export c, p, rationalTimeSteps, irrationalTimeSteps, numNegEigenvalues, numPosEigenvalues, initFunc, initFunc2, initFunc3

c = 9
p = 2.01
rationalTimeSteps = [0, 1, 1 // 2, 1 // 3, 1 // 4, 1 // 5, 1 // 6, 1 // 7, 1 // 8, 1 // 9, 1 // 10, 2 // 15, 1 // 15, 1 // 30]
irrationalTimeSteps = [0.0001, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5]

numNegEigenvalues = 1000
negEigenList = [1.77, 1.94, 3.18325, 3.1994]
for i in 5:(numNegEigenvalues / 2 + 2)
    lower = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) - 0.1
    higher = i - (i - sqrt(i^2 - c)) * (1 - p / (2 * pi)) + 0.1
    append!(negEigenList, [lower, higher])
end

numPosEigenvalues = 5
posEigenList = [0.43, 1.66, 2.33, 2.71, 2.93]

function initFunc(x)
    jump = pi
    if x <= jump - 2 * pi
        return 0
    elseif x <= 0
        return 1
    elseif x <= jump
        return 0
    else
        return 1
    end
end

initFunc2(x) = 1 - (1 + exp(-2 * 100 * x))^(-1) + (1 + exp(-2 * 100 * (x - pi)))^(-1) - (1 + exp(-2 * 100 * (x- 2 * pi)))^(-1)

function initFunc3(x)
    jump = pi
    if x <= jump - 2 * pi
        return -x / (2 * pi) - 1
    elseif x <= jump
        return -x / (2 * pi)
    elseif x <= jump + 2 * pi
        return -x / (2 * pi) + 1
    else 
        return -x / (2 * pi) + 2
    end
end

end