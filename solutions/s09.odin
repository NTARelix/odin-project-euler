package solutions

import "core:math/linalg"

s09 :: proc(ctx: ^RunContext) -> u64 {
    for a in cast(u64)0..=1000 {
        a2 := cast(u64)linalg.pow(cast(f64)a, auto_cast 2)
        for b in cast(u64)(a + 1)..=(1000 - a) {
            b2 := cast(u64)linalg.pow(cast(f64)b, 2)
            c := 1000 - a - b
            c2 := cast(u64)linalg.pow(cast(f64)c, 2)
            if a2 + b2 == c2 && a < b && b < c {
                return a * b * c
            }
        }
    }
    return 0
}
