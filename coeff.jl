module Coeff

import Pkg
Pkg.add("QuadGK")

include("./settings.jl")
include("./negEigenfunction.jl")
include("./posEigenfunction.jl")
include("./zeroEigenfunction.jl")

using QuadGK
using .NegEigenfunction
using .PosEigenfunction
using .ZeroEigenfunction

export negCoeffList, posCoeffList, zeroCoeff

negCoeffList = Float64[]
posCoeffList = Float64[]

for i in 1:numNegEigenvalues
    print("Find negative coefficient $(i): ")
    @time begin
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