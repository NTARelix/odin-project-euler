package solutions

s14 :: proc(ctx: ^RunContext) -> u64 {
    longest_sequence_starting_number: u64 = 1
    longest_sequence_size: u64 = 1
    for starting_number in cast(u64)2..=1_000_000 {
        n := starting_number
        sequence_size: u64 = 1
        for n != 1 {
            sequence_size += 1
            if n % 2 == 0 {
                n = n / 2
            } else {
                n = (3 * n) + 1
            }
        }
        if sequence_size > longest_sequence_size {
            longest_sequence_starting_number = starting_number
            longest_sequence_size = sequence_size
        }
    }
    return longest_sequence_starting_number
}
