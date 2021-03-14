#=
Advent of Code 2020 Day 3
https://adventofcode.com/2020/day/3
=#

function count_trees(slope, tree_map)::Int8
    # Initialize starting variables
    n_tree = 0;
    tree_sym = '#';
    loc = [1, 1];
    line_len = length(tree_map[1]);

    while loc[2] < length(tree_map)
        loc = loc + slope;
        x = mod(loc[1], line_len);
        if x == 0
            x = line_len;
        end
        y = loc[2];
        if tree_map[y][x] == tree_sym
            n_tree += 1;
        end
    end
    println("Slope: $slope, # Trees: $n_tree")
    return n_tree
end

function main()
    # Read the input file
    cd(dirname(@__FILE__()));
    tree_map = readlines("./input.txt");

    prod = 1.0;
    slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]];
    for slope in slopes
        prod = prod * count_trees(slope, tree_map);
    end
    println("Final Ans: $prod");
end

main()