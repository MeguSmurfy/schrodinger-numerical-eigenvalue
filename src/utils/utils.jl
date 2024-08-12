module Utils

import Pkg
Pkg.add("CalculusWithJulia")

using CalculusWithJulia

function newtonIterator(f::Function, x)
    return x - f(x) * D(f)(x) / ((D(f)(x))^2 - f(x) * D(f, 2)(x))
end

function newtonMethod(f::Function, numList)
    result = numList
    for i in 1:10
        result = map(x -> newtonIterator(f, x), result)
    end
    return result
end

end