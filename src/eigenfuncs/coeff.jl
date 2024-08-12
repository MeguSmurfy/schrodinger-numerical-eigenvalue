module Coeff

import Pkg
Pkg.add("QuadGK")

include("../config/config.jl")
include("./negEigenfunction.jl")
include("./posEigenfunction.jl")
include("./zeroEigenfunction.jl")

using QuadGK
using .Config
using .NegEigenfunction: negEigenFunc
using .PosEigenfunction: posEigenFunc
using .ZeroEigenfunction: zeroEigenFunc

export negCoeffList, posCoeffList, zeroCoeff, revivalCoeffList

negCoeffList = Float64[]
posCoeffList = Float64[]
revivalCoeffList = Float64[]

for i in 1:numNegEigenvalues
    print("Find negative coefficients $i: ")
    @time begin  
        a = quadgk(x -> negEigenFunc(x, i) * initFunc3(x), 0, 2 * pi, rtol = 1e-5)[1]
        # a = negEigenFunc(pi, i) - quadgk(x -> negEigenFunc(x, i), 0, 2 * pi, rtol = 1e-5)[1] / (2 * pi)
        b = quadgk(x -> (negEigenFunc(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(negCoeffList, a/b)
    end
end

print("Find positive coefficients: ")
@time begin
    for i in 1:numPosEigenvalues
        a = quadgk(x -> posEigenFunc(x, i) * initFunc3(x), 0, 2 * pi, rtol = 1e-5)[1]
        # a = posEigenFunc(pi, i) - quadgk(x -> posEigenFunc(x, i), 0, 2 * pi, rtol = 1e-5)[1] / (2 * pi)
        b = quadgk(x -> (posEigenFunc(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(posCoeffList, a/b)
    end
end

zeroCoeff = quadgk(x -> zeroEigenFunc(x) * initFunc3(x), 0, 2 * pi, rtol = 1e-5)[1] / quadgk(x -> (zeroEigenFunc(x))^2, 0, 2 * pi, rtol = 1e-5)[1]

# zeroCoeff = (zeroEigenFunc(pi) - quadgk(x -> zeroEigenFunc(x), 0, 2 * pi, rtol = 1e-5)[1] / (2 * pi)) / quadgk(x -> (zeroEigenFunc(x))^2, 0, 2 * pi, rtol = 1e-5)[1]

end