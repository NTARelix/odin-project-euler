package solutions

s12 :: proc() -> u64 {
    min_divisor_count :: 500
    triangle_num: u64 = 0
    for n: u64 = 0;; n += 1 {
        triangle_num += n
        factor_count := 2 // assume 2 factors: 1 and triangle_num
        upper_factor_limit := triangle_num
        for potential_factor: u64 = 2; potential_factor < upper_factor_limit; potential_factor += 1 {
            if triangle_num % potential_factor == 0 {
                factor_count += 2
                upper_factor_limit = triangle_num / potential_factor
            }
        }
        if factor_count >= min_divisor_count {
            break
        }
    }
    return triangle_num
}
