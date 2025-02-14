package solutions

s07 :: proc() -> u64 {
    prime_cache: [dynamic]u64
    append(&prime_cache, 2)
    for num: u64 = 3;; num += 2 {
        is_divisible_by_prime := false
        for prime in prime_cache {
            if num % prime == 0 {
                is_divisible_by_prime = true
                break
            }
        }
        if !is_divisible_by_prime {
            append(&prime_cache, num)
            if len(prime_cache) == 10001 {
                return num
            }
        }
    }
}
