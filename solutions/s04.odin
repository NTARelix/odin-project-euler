package solutions

import "core:math/linalg"

@(private)
count_digits :: proc(num: u64) -> u8 {
    for digits: u8 = 0; digits < max(u8); digits += 1 {
        if num < cast(u64)linalg.pow(cast(f64)10, cast(f64)digits) {
            return digits
        }
    }
    return 0
}

@(private)
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

// https:\/\/projecteuler.net/problem=4
s04 :: proc() -> u64 {
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
