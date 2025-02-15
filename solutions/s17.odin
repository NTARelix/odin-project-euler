package solutions

import "core:fmt"

@(private)
get_words :: proc(num: u16, words: ^[dynamic]string) {
    wc := make(map[u16]string)
    wc[1] = "one"
    wc[2] = "two"
    wc[3] = "three"
    wc[4] = "four"
    wc[5] = "five"
    wc[6] = "six"
    wc[7] = "seven"
    wc[8] = "eight"
    wc[9] = "nine"
    wc[10] = "ten"
    wc[11] = "eleven"
    wc[12] = "twelve"
    wc[13] = "thirteen"
    wc[14] = "fourteen"
    wc[15] = "fifteen"
    wc[16] = "sixteen"
    wc[17] = "seventeen"
    wc[18] = "eighteen"
    wc[19] = "nineteen"
    wc[20] = "twenty"
    wc[30] = "thirty"
    wc[40] = "forty"
    wc[50] = "fifty"
    wc[60] = "sixty"
    wc[70] = "seventy"
    wc[80] = "eighty"
    wc[90] = "ninety"
    wc[100] = "hundred"
    wc[1000] = "thousand"
    ones := num % 10
    tens := (num % 100) / 10
    hundreds := (num % 1000) / 100
    is_thousand := num == 1000
    if is_thousand {
        append(words, wc[1], wc[1000])
        return
    }
    if hundreds > 0 {
        append(words, wc[hundreds], wc[100])
        if tens > 0 || ones > 0 {
            append(words, "and")
        }
    }
    if tens == 1 {
        append(words, wc[(tens * 10) + ones])
        return
    }
    if tens > 1 {
        append(words, wc[tens * 10])
    } else if tens == 0 {
        // produces no words
    }
    if ones > 0 {
        append(words, wc[ones])
    }
}

@(private)
count_letters :: proc(words: ^[dynamic]string) -> u64 {
    count: u64 = 0
    for word in words {
        count += cast(u64)len(word)
    }
    return count
}

@(private)
print_num_words :: proc(num: u16, num_letter_count: u64, total_count: u64, words: ^[dynamic]string) {
    fmt.printf("num=%i; num_letter_count=%i; total_count=%i; words=[ ", num, num_letter_count, total_count)
    for word in words {
        fmt.print(word, " ")
    }
    fmt.println("]")
}

s17 :: proc(ctx: ^RunContext) -> u64 {
    total_count: u64 = 0
    words: [dynamic]string
    for num in 1..=1000 {
        get_words(cast(u16)num, &words)
        num_letter_count := count_letters(&words)
        total_count += num_letter_count
        if ctx.debug {
            print_num_words(cast(u16)num, num_letter_count, total_count, &words)
        }
        clear(&words)
    }
    return total_count
}
