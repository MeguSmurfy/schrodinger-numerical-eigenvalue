test_coeff_list = Float64[]
for i in 1:num_neg_eigenvalues/2
    a = quadgk(x -> cos(i * x) * init_func(x), 0, 2 * pi, rtol = 1e-5)[1]
    b = quadgk(x -> (cos(i * x))^2, 0, 2 * pi, rtol = 1e-5)[1]
    push!(test_coeff_list, a/b)

    a = quadgk(x -> sin(i * x) * init_func(x), 0, 2 * pi, rtol = 1e-5)[1]
    b = quadgk(x -> (sin(i * x))^2, 0, 2 * pi, rtol = 1e-5)[1]
    push!(test_coeff_list, a/b)
end

function test_sol_real(x, timestep)
    test_cos_list = map(i -> cos(i^2 * timestep), range(1, num_neg_eigenvalues, step=1))
    result = 0
    for i in 1:Int.(num_neg_eigenvalues/2)
        result += @. test_coeff_list[Int.(2*i-1)] * test_cos_list[i] * cos(i*x)
        result += @. test_coeff_list[Int.(2*i)] * test_cos_list[i] * sin(i*x)
    end
    return result
end