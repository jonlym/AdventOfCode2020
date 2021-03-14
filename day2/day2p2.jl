#=
Advent of Code 2020 Day 2 Part 2
https://adventofcode.com/2020/day/2
=#

function main()
    # Read the input file
    cd(dirname(@__FILE__()));

    n_valid_passwords = 0;
    for line in eachline("./input.txt")
        line_split = split(line, " ");
        special_char = replace.(line_split[2], ":" => "");
        (min_char, max_char) = [parse(Int64, x) for x in split(line_split[1], "-")];
        password = line_split[3]

        n_match = 0
        if password[min_char:min_char] == special_char
            n_match += 1
        end
        if password[max_char:max_char] == special_char
            n_match += 1
        end
        
        if n_match == 1
            println("Valid password: $line");
            n_valid_passwords = n_valid_passwords + 1;
        end
    end
    println("# of valid passwords: $n_valid_passwords")
end

main()