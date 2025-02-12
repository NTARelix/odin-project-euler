package main

import "core:fmt"

// https:\/\/projecteuler.net/problem=1
solution1 :: proc() -> u64 {
    sum: u64 = 0
    for i: u64 = 0; i < 1000; i += 1 {
        if i % 3 == 0 || i % 5 == 0 {
            sum += i
        }
    }
    return sum
}

// https:\/\/projecteuler.net/problem=2
solution2 :: proc() -> u64 {
    prev: u64 = 1
    curr: u64 = 2
    sum: u64 = 0
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

// https:\/\/projecteuler.net/problem=3
solution3 :: proc() -> u64 {
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

main :: proc() {
    fmt.printfln("Solution 1: %i", solution1())
    fmt.printfln("Solution 2: %i", solution2())
    fmt.printfln("Solution 3: %i", solution3())
}
