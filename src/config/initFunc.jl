module InitFunc

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