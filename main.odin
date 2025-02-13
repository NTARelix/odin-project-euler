package main

import "core:fmt"
import "core:math/linalg"
import "core:time"

count_digits :: proc(num: u64) -> u8 {
    for digits: u8 = 0; digits < max(u8); digits += 1 {
        if num < cast(u64)linalg.pow(cast(f64)10, cast(f64)digits) {
            return digits
        }
    }
    return 0
}

is_palindrome :: proc(num: u64) -> bool {
    upper_digit_i: u8 = count_digits(num)
    lower_digit_i: u8 = 0
    for upper_digit_i > lower_digit_i {
        upper_digit := (num / cast(u64)linalg.pow(cast(f64)10, cast(f64)upper_digit_i - 1)) % 10
        lower_digit := (num / cast(u64)linalg.pow(cast(f64)10, cast(f64)lower_digit_i)) % 10
        if upper_digit != lower_digit {
            return false
        }
        upper_digit_i -= 1
        lower_digit_i += 1
    }
    return true
}

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

// https:\/\/projecteuler.net/problem=4
solution4 :: proc() -> u64 {
    max: u64 : 999
    min: u64 : 100
    largest_palindrome_product: u64 = 0
    for left_operand: u64 = max; left_operand >= min; left_operand -= 1 {
        square := left_operand * left_operand
        if square <= largest_palindrome_product {
            break // no remaining products could be greater than the current largest product
        }
        // right operand starting at `max` would repeat products previously computed so we skip down to the squaring operation and all right operands below
        for right_operand: u64 = left_operand; right_operand >= min; right_operand -= 1 {
            product := left_operand * right_operand
            if product <= largest_palindrome_product {
                break // no remaining products at the current left operand could be greater than the current largest product
            }
            if is_palindrome(product) {
                largest_palindrome_product = product
                break // no remaining products at the current left operand could be greater than the new largest product
            }
        }
    }
    return largest_palindrome_product
}

solution5 :: proc() -> u64 {
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

main :: proc() {
    solutions := []proc() -> u64{
        solution1,
        solution2,
        solution3,
        solution4,
        solution5,
    }
    stopwatch: time.Stopwatch
    for solution, i in solutions {
        time.stopwatch_reset(&stopwatch)
        time.stopwatch_start(&stopwatch)
        result := solution()
        time.stopwatch_stop(&stopwatch)
        dur_ms := cast(f64)time.stopwatch_duration(stopwatch) / cast(f64)time.Millisecond
        fmt.printfln("Solution %i (%f ms): %i", i + 1, dur_ms, result)
    }
}
