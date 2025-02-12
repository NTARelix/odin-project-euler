package main

import "core:fmt"

// https:\/\/projecteuler.net/problem=1
solution1 :: proc() -> u64 {
    sum : u64 = 0
    for i : u64 = 0; i < 1000; i += 1 {
        if i % 3 == 0 || i % 5 == 0 {
            sum += i
        }
    }
    return sum
}

main :: proc() {
    fmt.printfln("Solution 1: %i", solution1())
}
