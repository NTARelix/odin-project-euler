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

// https:\/\/projecteuler.net/problem=2
solution2 :: proc() -> u64 {
    prev : u64 = 1
    curr : u64 = 2
    sum : u64 = 0
    for curr < 4000000 {
        if curr % 2 == 0 {
            sum += curr
        }
        next := prev + curr
        prev = curr
        curr = next
    }
    return sum
}

main :: proc() {
    fmt.printfln("Solution 1: %i", solution1())
    fmt.printfln("Solution 2: %i", solution2())
}
