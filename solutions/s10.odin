package solutions

s10 :: proc() -> u64 {
    prime_cache: [dynamic]u64
    append(&prime_cache, 2)
    // find primes
    for i: u64 = 3; i < 2_000_000; i += 2 {
        is_divisible_by_prime := false
        for prime in prime_cache {
            if prime > i / 3 {
                break // highest possible prime is at half of `i`, but all `i`s are odd so we skip all primes greater than `i/3`
            }
            if i % prime == 0 {
                is_divisible_by_prime = true
                break
            }
        }
        if !is_divisible_by_prime {
            append(&prime_cache, i)
        }
    }
    // sum primes
    sum: u64 = 0
    for prime in prime_cache {
        sum += prime
    }
    return sum
}
