#=
Advent of Code 2020 Day 1
https://adventofcode.com/2020/day/1
=#
using CSV
using DataFrames
using Combinatorics

function main()
    # Number of values to add
    n_vals = 3;
    # Critical sum value
    crit_sum_val = 2020;

    # Read the input file
    cd(dirname(@__FILE__()));
    data_df = CSV.read("./input.csv", DataFrame);

    data_vec = vec(convert(Array, data_df));

    # Iterate over list, n_vals values at a time
    for vals in combinations(data_vec, n_vals)
        if sum(vals) == crit_sum_val
            prod_val = prod(vals);
            println("$vals : $prod_val");
        end
    end
end

main()