module DirCreator

include("../config/config.jl")

using .Config

export directoryName, fileName

mode = Config.mode
pMode = Config.pMode
revival = Config.revival
des = Config.initDesignator

function createDirectory()
    directoryName = "../../"

    if mode == 0
        header = "images"
        suffixes = ["rational_real", "rational_img", "irrational_real", "irrational_img"]
    else
        header = "videos"
    end
    
    if pMode == 0
        directoryName = directoryName * "$(header)\\$(Int.(c))_$(numerator(p))pi$(denominator(p))_$(des)"
    else
        directoryName = directoryName * "$(header)\\$(Int.(c))_$(p)_$(des)"
    end
    
    if revival
        directoryName = directoryName * "_revival"
    end

    if !isdir(directoryName)
        mkpath(directoryName)
    end

    if mode == 0
        for suffix in suffixes
            suffixedName = directoryName * "\\$(suffix)"
            if !isdir(suffixedName)
                mkpath(suffixedName)
            end
        end
    end

    return directoryName
end

end