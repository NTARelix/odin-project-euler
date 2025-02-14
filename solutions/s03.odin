package solutions

// https:\/\/projecteuler.net/problem=3
s03 :: proc(ctx: ^RunContext) -> u64 {
    largest_prime_factor: u64 = 600851475143
    was_divided: bool = true // technically not true, but we need this to get into the loop
    for was_divided {
        was_divided = false
        for i in 2..<largest_prime_factor {
            if largest_prime_factor % i == 0 {
                largest_prime_factor = largest_prime_factor / i
                was_divided = true
                break
            }
        }
    }
    return largest_prime_factor
}
