package main

import "core:fmt"
import "core:math/linalg"
import "core:os"
import "core:strconv"
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
    prime_cache: [dynamic]u64
    append(&prime_cache, 2)
    for num: u64 = 3;; num += 2 {
        is_divisible_by_prime := false
        for prime in prime_cache {
            if num % prime == 0 {
                is_divisible_by_prime = true
                break
            }
        }
        if !is_divisible_by_prime {
            append(&prime_cache, num)
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

solution10 :: proc() -> u64 {
    prime_cache: [dynamic]u64
    append(&prime_cache, 2)
    // find primes
    for i: u64 = 3; i < 2_000_000; i += 2 {
        is_divisible_by_prime := false
        for prime in prime_cache {
            if prime > i / 3 {
                break // highest possible prime is at half of `i`, but all `i`s are odd so we skip all primes greater than `i/3`
            }
            if i % prime == 0 {
                is_divisible_by_prime = true
                break
            }
        }
        if !is_divisible_by_prime {
            append(&prime_cache, i)
        }
    }
    // sum primes
    sum: u64 = 0
    for prime in prime_cache {
        sum += prime
    }
    return sum
}

solution11 :: proc() -> u64 {
    grid := []u64{
        08, 02, 22, 97, 38, 15, 00, 40, 00, 75, 04, 05, 07, 78, 52, 12, 50, 77, 91, 08,
        49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 04, 56, 62, 00,
        81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 03, 49, 13, 36, 65,
        52, 70, 95, 23, 04, 60, 11, 42, 69, 24, 68, 56, 01, 32, 56, 71, 37, 02, 36, 91,
        22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80,
        24, 47, 32, 60, 99, 03, 45, 02, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50,
        32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70,
        67, 26, 20, 68, 02, 62, 12, 20, 95, 63, 94, 39, 63, 08, 40, 91, 66, 49, 94, 21,
        24, 55, 58, 05, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72,
        21, 36, 23, 09, 75, 00, 76, 44, 20, 45, 35, 14, 00, 61, 33, 97, 34, 31, 33, 95,
        78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 03, 80, 04, 62, 16, 14, 09, 53, 56, 92,
        16, 39, 05, 42, 96, 35, 31, 47, 55, 58, 88, 24, 00, 17, 54, 24, 36, 29, 85, 57,
        86, 56, 00, 48, 35, 71, 89, 07, 05, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58,
        19, 80, 81, 68, 05, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 04, 89, 55, 40,
        04, 52, 08, 83, 97, 35, 99, 16, 07, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66,
        88, 36, 68, 87, 57, 62, 20, 72, 03, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69,
        04, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 08, 46, 29, 32, 40, 62, 76, 36,
        20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 04, 36, 16,
        20, 73, 35, 29, 78, 31, 90, 01, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 05, 54,
        01, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 01, 89, 19, 67, 48,
    }
    grid_size :: 20
    seq_size :: 4
    right_end :: grid_size - seq_size
    down_end :: grid_size - seq_size
    left_end :: seq_size
    Vec2 :: struct { x: i64, y: i64 }
    dirs :: []Vec2{
        {x = 1, y = 0}, // right
        {x = 1, y = 1}, // down-right
        {x = 0, y = 1}, // down
        {x = -1, y = 1}, // down-left
    }
    largest_product: u64 = 0
    for x_orig in cast(i64)0..<grid_size {
        for y_orig in cast(i64)0..<grid_size {
            for dir_vec in dirs {
                product := grid[x_orig + (y_orig * grid_size)] // start with cell at origin: (x_orig, y_orig)
                for seq_i in cast(i64)1..<seq_size {
                    x := x_orig + (dir_vec.x * seq_i)
                    y := y_orig + (dir_vec.y * seq_i)
                    if x < 0 || x >= grid_size || y < 0 || y >= grid_size {
                        product = 0
                        break
                    }
                    val := grid[x + (y * grid_size)]
                    product *= val
                }
                if product > largest_product {
                    largest_product = product
                }
            }
        }
    }
    return largest_product
}

solution12 :: proc() -> u64 {
    min_divisor_count :: 500
    triangle_num: u64 = 0
    for n: u64 = 0;; n += 1 {
        triangle_num += n
        factor_count := 2 // assume 2 factors: 1 and triangle_num
        upper_factor_limit := triangle_num
        for potential_factor: u64 = 2; potential_factor < upper_factor_limit; potential_factor += 1 {
            if triangle_num % potential_factor == 0 {
                factor_count += 2
                upper_factor_limit = triangle_num / potential_factor
            }
        }
        if factor_count >= min_divisor_count {
            break
        }
    }
    return triangle_num
}

run_solution :: proc(num: int, solution: proc() -> u64) {
    stopwatch: time.Stopwatch
    time.stopwatch_start(&stopwatch)
    result := solution()
    time.stopwatch_stop(&stopwatch)
    dur_ms := cast(f64)time.stopwatch_duration(stopwatch) / cast(f64)time.Millisecond
    fmt.printfln("Solution %i (%f ms): %i", num, dur_ms, result)
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
        solution10,
        solution11,
        solution12,
    }
    if len(os.args) >= 2 {
        solution_to_run: int
        if parsed, ok := strconv.parse_int(os.args[1]); ok {
            solution_to_run = parsed
        } else {
            fmt.printfln("failed to parse first parameter as int: %s", os.args[1])
            return
        }
        i: int
        if solution_to_run > 0 {
            i = solution_to_run - 1
        } else if solution_to_run < 0 {
            i = len(solutions) + solution_to_run
        }
        run_solution(i + 1, solutions[i])
    } else {
        for i in 0..<len(solutions) {
            run_solution(i + 1, solutions[i])
        }
    }
}
