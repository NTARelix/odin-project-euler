package solutions

// https:\/\/projecteuler.net/problem=1
s01 :: proc(ctx: ^RunContext) -> u64 {
    sum: u64 = 0
    for i: u64 = 0; i < 1000; i += 1 {
        if i % 3 == 0 || i % 5 == 0 {
            sum += i
        }
    }
    return sum
}
