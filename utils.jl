module Utils

import Pkg
Pkg.add("CalculusWithJulia")

using CalculusWithJulia

# Newton's method
function newtonIterate(f::Function, x)
    return x - f(x) * D(f)(x) / ((D(f)(x))^2 - f(x) * D(f, 2)(x))
end

end