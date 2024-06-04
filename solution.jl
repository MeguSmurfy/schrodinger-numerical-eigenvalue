module Solution

include("./settings.jl")
include("./eigenvalues.jl")
include("./coeff.jl")
include("./negEigenfunction.jl")
include("./posEigenfunction.jl")
include("./zeroEigenfunction.jl")

using .Settings
using .Coeff
using .Eigenvalues
using .NegEigenfunction
using .PosEigenfunction
using .ZeroEigenfunction

function negSolReal(x, timestep)
    negCosList = map(i -> cos((negEigenList[i])^2 * timestep), range(1, numNegEigenvalues, step=1))
    result = 0
    for i in 1:numNegEigenvalues
        result += @. negCoeffList[i] * negCosList[i] * negEigenFunc(x, i)
    end
    return result
end

function negSolImg(x, timestep)
    negSinList = map(i -> sin((negEigenList[i])^2 * timestep), range(1, numNegEigenvalues, step=1))
    result = 0
    for i in 1:numNegEigenvalues
        result += @. negCoeffList[i] * negSinList[i] * negEigenFunc(x, i)
    end
    return result
end

function posSolReal(x, timestep)
    posCosList = map(i -> cos((posEigenList[i])^2 * timestep), range(1, numPosEigenvalues, step=1))
    result = 0
    for i in 1:numPosEigenvalues
        result += @. posCoeffList[i] * posCosList[i] * posEigenFunc(x, i)
    end
    return result
end

function posSolImg(x, timestep)
    posSinList = map(i -> -sin((posEigenList[i])^2 * timestep), range(1, numPosEigenvalues, step=1))
    result = 0
    for i in 1:numPosEigenvalues
        result += @. posCoeffList[i] * posSinList[i] * posEigenFunc(x, i)
    end
    return result
end

function zeroSol(x)
    if zeroEigenvalue
        result = @. zeroCoeff * zeroEigenFunc(x)
    else
        result = 0
    end
    return result
end

solReal(x, timestep) = negSolReal(x, timestep) + posSolReal(x, timestep) + zeroSol(x)
solImg(x, timestep) = negSolImg(x, timestep) + posSolImg(x, timestep)

end