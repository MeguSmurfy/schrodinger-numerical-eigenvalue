module Coeff

import Pkg
Pkg.add("QuadGK")

include("./settings.jl")
include("./negEigenfunction.jl")
include("./posEigenfunction.jl")
include("./zeroEigenfunction.jl")

using QuadGK
using .Settings
using .NegEigenfunction: negEigenFunc
using .PosEigenfunction: posEigenFunc
using .ZeroEigenfunction: zeroEigenFunc

export negCoeffList, posCoeffList, zeroCoeff

negCoeffList = Float64[]
posCoeffList = Float64[]

print("Find negative coefficients: ")
@time begin     
    for i in 1:numNegEigenvalues
        a = quadgk(x -> negEigenFunc(x, i) * initFunc(x), 0, 2 * pi, rtol = 1e-5)[1]
        b = quadgk(x -> (negEigenFunc(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(negCoeffList, a/b)
    end
end

print("Find positive coefficients: ")
@time begin
    for i in 1:numPosEigenvalues
        a = quadgk(x -> posEigenFunc(x, i) * initFunc(x), 0, 2 * pi, rtol = 1e-5)[1]
        b = quadgk(x -> (posEigenFunc(x, i))^2, 0, 2 * pi, rtol = 1e-5)[1]
        push!(posCoeffList, a/b)
    end
end

zeroCoeff = quadgk(x -> zeroEigenFunc(x) * initFunc(x), 0, 2 * pi, rtol = 1e-5)[1] / 
                quadgk(x -> (zeroEigenFunc(x))^2, 0, 2 * pi, rtol = 1e-5)[1]

end