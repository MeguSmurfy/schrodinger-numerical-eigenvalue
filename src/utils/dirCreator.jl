module DirCreator

include("../config/config.jl")

using .Config

increment = Config.increment
c = Config.c
p = Config.p
numNegEigenvalues = Config.numNegEigenvalues
pMode = Config.pMode
des = Config.initDesignator

function createDirectory(mode, revival)
    # determine headers
    if mode == 0
        header = "images"
    else
        header = "videos"
    end

    # determine suffixes
    if revival
        suffixes = ["rational_real", "rational_real_revival", "rational_real_revival_diff"]
    else
        suffixes = ["rational_real", "rational_img", "irrational_real", "irrational_img"]
    end
    
    # initialize directory name
    dir = "$(header)\\$(Int.(c))"

    # add discontinuity information
    if pMode == 0
        dir = dir * "_$(numerator(p))pi$(denominator(p))"
    else
        dir = dir * "_$(p)"
    end

    # add plotting information
    dir = dir * "_$(des)_$(numNegEigenvalues)_$(increment)pi"
    
    # add revival option
    if revival
        dir = dir * "_revival"
    end

    # make directory
    if !isdir(dir)
        mkpath(dir)
    end

    # make subdirectories from suffixes
    for suffix in suffixes
        suffixed = dir * "\\$(suffix)"
        if !isdir(suffixed)
            mkpath(suffixed)
        end
    end

    return dir
end

end