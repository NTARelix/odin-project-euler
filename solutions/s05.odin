package solutions

s05 :: proc(ctx: ^RunContext) -> u64 {
    max_factor: u64 : 20
    for potential_multiple := max_factor;; potential_multiple += max_factor {
        all_divisible := true
        for divisor in 1..=max_factor {
            if potential_multiple % divisor != 0 {
                all_divisible = false
                break
            }
        }
        if all_divisible {
            return potential_multiple
        }
    }
}
