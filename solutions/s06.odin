package solutions

import "core:math/linalg"

@(private)
sum_of_squares :: proc(max: u64) -> u64 {
    sum: u64 = 0
    for n in 1..=max {
        sum += cast(u64)linalg.pow(cast(f64)n, 2)
    }
    return sum
}

@(private)
square_of_sum :: proc(max: u64) -> u64 {
    sum: u64 = 0
    for n in 1..=max {
        sum += n
    }
    return cast(u64)linalg.pow(cast(f64)sum, 2)
}

s06 :: proc() -> u64 {
    max: u64 : 100
    return square_of_sum(max) - sum_of_squares(max)
}
