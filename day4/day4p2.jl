#=
Advent of Code 2020 Day 4 Part 2
https://adventofcode.com/2020/day/4
=#

function is_valid_year(;year, low, high)::Bool
    # Check if birth year is 4 digits
    if ~occursin(r"^[0-9]{4}$", year)
        return false;
    end
    
    year_int = parse(Int, year);
    # Check if birth year is not in range
    if (year_int < low) || (year_int > high)
        return false;
    end

    return true;
end

function main()
    # Read the input file
    cd(dirname(@__FILE__()));
    f_ptr = open("./input.txt", "r")
    input_str = read(f_ptr, String);

    n_valid = 0;
    req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];
    opt_fields = ["cid"];
    min_fields = length(req_fields);
    valid_eye_colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];

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

        invalid_field_found = false;
        n_req_fields = 0;
        for field in fields
            # Count valid fields
            field_name, field_val = split(field, ":");
            if field_name ∈ req_fields
                n_req_fields += 1;

                # Check the value for accuracy
                val_len = length(field_val)
                if field_name == "byr"
                    invalid_field_found = ~(is_valid_year(year=field_val,
                                                          low=1920,
                                                          high=2002));
                elseif field_name == "iyr"
                    invalid_field_found = ~(is_valid_year(year=field_val,
                                                          low=2010,
                                                          high=2020));
                elseif field_name == "eyr"
                    invalid_field_found = ~(is_valid_year(year=field_val,
                                                          low=2020,
                                                          high=2030));
                elseif field_name == "hgt"
                    # Skip if height is not a number in inches or centimeters
                    if ~(occursin(r"^[0-9]+((cm)|(in))$", field_val))
                        invalid_field_found = true;
                        break;
                    end

                    height_int = parse(Int, replace(field_val, r"(cm)|(in)" => ""))
                    if occursin(r"cm", field_val)
                        if (height_int < 150) || (height_int > 193)
                            invalid_field_found = true;
                            break;
                        end
                    elseif occursin(r"in", field_val)
                        if (height_int < 59) || (height_int > 76)
                            invalid_field_found = true;
                            break;
                        end
                    else
                        error("Invalid unit detected.")
                    end
                elseif field_name == "hcl"
                    # Check hair format
                    if ~(occursin(r"^\#([0-9]|([a-f])){6}$", field_val))
                        invalid_field_found = true;
                        break;
                    end
                elseif field_name == "ecl"
                    # Check eye color
                    if field_val ∉ valid_eye_colors
                        invalid_field_found = true;
                        break;
                    end
                elseif field_name == "pid"
                    # Check Passport ID
                    if ~(occursin(r"^[0-9]{9}$", field_val))
                        invalid_field_found = true;
                        break;
                    end
                end
                
                if invalid_field_found
                    break;
                end
            end
        end

        # Skip record if an invalid field was found
        if invalid_field_found
            continue;
        end

        # Skip record if it does not have the required fields
        if n_req_fields < min_fields
            continue
        end

        # Count record since it has passed all tests
        n_valid += 1;
    end

    println("# of Valid Passports: $n_valid");
end

main()