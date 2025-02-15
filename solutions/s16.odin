package solutions

import "core:fmt"
import "core:math/linalg"

@(private)
Digits :: [1024]u8

@(private)
sum_digits :: proc(digits: ^Digits) -> u64 {
    sum: u64 = 0
    for digit in digits {
        sum += cast(u64)digit
    }
    return sum
}

@(private)
carry_over_digits :: proc(digits: ^Digits) {
    for digit_index := 0; digit_index < len(digits); digit_index += 1 {
        digit := digits[digit_index]
        if digit >= 10 {
            index := digit_index
            digits[index] = digit % 10
            digits[index + 1] += digit / 10
        }
    }
}

@(private)
double_digits :: proc(digits: ^Digits) {
    for digit, i in digits {
        digits[i] = digit * 2
    }
}

@(private)
print_digits :: proc(digits: ^Digits) {
    found_positive := false
    #reverse for digit in digits {
        if found_positive == false && digit == 0 {
            continue
        }
        found_positive = true
        fmt.print(digit)
    }
    fmt.print("\n")
}

s16 :: proc(ctx: ^RunContext) -> u64 {
    digits: Digits
    digits[0] = 1
    for i in 0..<1000 {
        if ctx.debug {
            fmt.print("Before: ")
            print_digits(&digits)
        }
        double_digits(&digits)
        carry_over_digits(&digits)
        if ctx.debug {
            fmt.print("After: ")
            print_digits(&digits)
        }
    }
    return sum_digits(&digits)
}
