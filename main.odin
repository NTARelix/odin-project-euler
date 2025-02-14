package main

import "core:fmt"
import "core:math/linalg"
import "core:strings"
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

sum_of_squares :: proc(max: u64) -> u64 {
    sum: u64 = 0
    for n in 1..=max {
        sum += cast(u64)linalg.pow(cast(f64)n, 2)
    }
    return sum
}

square_of_sum :: proc(max: u64) -> u64 {
    sum: u64 = 0
    for n in 1..=max {
        sum += n
    }
    return cast(u64)linalg.pow(cast(f64)sum, 2)
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

solution6 :: proc() -> u64 {
    max: u64 : 100
    return square_of_sum(max) - sum_of_squares(max)
}

solution7 :: proc() -> u64 {
    prime_cache := new(map[u64]struct{})
    prime_cache[2] = {}
    for num: u64 = 3;; num += 2 {
        is_divisible_by_prime := false
        for prime in prime_cache {
            if num % prime == 0 {
                is_divisible_by_prime = true
                break
            }
        }
        if !is_divisible_by_prime {
            prime_cache[num] = {}
            if len(prime_cache) == 10001 {
                return num
            }
        }
    }
}

solution8 :: proc() -> u64 {
    digit_series_str := `7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450`
    product_slice_size :: 13
    largest_product: u64 = 0
    for i := 0; i < len(digit_series_str) - product_slice_size; i += 1 {
        product: u64 = 1
        for offset := 0; offset < product_slice_size; offset += 1 {
            digit_char := digit_series_str[i + offset]
            digit := cast(u64)(digit_char - '0')
            product *= digit
        }
        if product > largest_product {
            largest_product = product
        }
    }
    return largest_product
}

solution9 :: proc() -> u64 {
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

main :: proc() {
    solutions := []proc() -> u64{
        solution1,
        solution2,
        solution3,
        solution4,
        solution5,
        solution6,
        solution7,
        solution8,
        solution9,
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
