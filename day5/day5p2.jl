#=
Advent of Code 2020 Day 5 Part 2
https://adventofcode.com/2020/day/5
=#

function get_seat_range(is_upper_half, low, high)
    adjust_val = cld(high - low, 2);
    if is_upper_half
        low += adjust_val;
    else
        high -= adjust_val;
    end
    return low, high;
end

function get_row(seat_code)
    row_mapping = Dict('F' => false,
                       'B' => true);
    
    low = 0;
    high = 127;

    for seat_val in seat_code[1:7]
        is_upper_half = row_mapping[seat_val];
        low, high = get_seat_range(is_upper_half, low, high);
    end

    @assert low == high;
    return low
end

function get_col(seat_code)
    col_mapping = Dict('L' => false,
                       'R' => true);
    low = 0;
    high = 7;
                   
    for seat_val in seat_code[8:10]
        is_upper_half = col_mapping[seat_val];
        low, high = get_seat_range(is_upper_half, low, high);
    end

    @assert low == high;
    return low
end

function main()
    cd(dirname(@__FILE__()));

    seat_ids = zeros(0);
    for record in eachline("./input.txt")
        row = get_row(record);
        col = get_col(record);

        seat_id = 8*row + col;
        append!(seat_ids, seat_id);
    end

    # Sort the seats
    sort!(seat_ids);

    # Get min and max values
    min_seat_id = minimum(seat_ids);
    max_seat_id = maximum(seat_ids);
    println(min_seat_id)
    println(max_seat_id)

    final_seat_id = -1;
    for i in 1:length(seat_ids)-2
        # Next seat must be 2 away
        if seat_ids[i+1] == (seat_ids[i] + 2)
            final_seat_id = seat_ids[i] + 1;
            break;
        end
    end

    if final_seat_id == -1
        error("Seat not found")
    end
    println("Your seat: $final_seat_id")
end

main()