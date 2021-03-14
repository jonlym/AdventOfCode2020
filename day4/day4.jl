#=
Advent of Code 2020 Day 4 Part 1
https://adventofcode.com/2020/day/4
=#

function main()
    # Read the input file
    cd(dirname(@__FILE__()));
    f_ptr = open("./input.txt", "r")
    input_str = read(f_ptr, String);

    n_valid = 0;
    req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];
    opt_fields = ["cid"];
    min_fields = length(req_fields);

    # Separate records
    records = split(input_str, "\n\n");
    for record in records
        # Split records into fields
        fields = split(record, r"\n| ");
        n_fields = length(fields)
        # Skip record if it doesn't have the minimum number of fields
        if n_fields < min_fields
            continue
        end

        n_req_fields = 0;
        for field in fields
            # Get field name
            field_name = split(field, ":")[1];
            if field_name in req_fields
                n_req_fields += 1;
            end
        end

        # Move to record if it does not have the required fields
        if n_req_fields < min_fields
            continue
        end

        # Count record since it has passed all tests
        n_valid += 1;
    end

    println("# of Valid Passports: $n_valid");
end

main()