package solutions

import "core:fmt"
import "core:math"

@(private)
size :: 120

@(private)
nums :: [size]u64{
                                                            0075,
                                                        0095,   0064,
                                                    17,     47,     82,
                                                18,     35,     87,     10,
                                            20,     04,     82,     47,     65,
                                        19,     01,     23,     75,     03,     34,
                                    88,     02,     77,     73,     07,     63,     67,
                                99,     65,     04,     28,     06,     16,     70,     92,
                            41,     41,     26,     56,     83,     40,     80,     70,     33,
                        41,     48,     72,     33,     47,     32,     37,     16,     94,     29,
                    53,     71,     44,     65,     25,     43,     91,     52,     97,     51,     14,
                70,     11,     33,     28,     77,     73,     17,     78,     39,     68,     17,     57,
            91,     71,     52,     38,     17,     14,     91,     43,     58,     50,     27,     29,     48,
        63,     66,     04,     68,     89,     53,     67,     30,     73,     16,     69,     87,     40,     31,
    04,     62,     98,     27,     23,     09,     70,     98,     73,     93,     38,     53,     60,     04,     23,
}

@(private)
get_layer_indices :: proc(nums: [size]u64) -> [dynamic]u64 {
    layer_indices: [dynamic]u64
    num_index: u64 = 0
    layer_index: u64 = 0
    for num_index < cast(u64)len(nums) {
        append(&layer_indices, num_index)
        layer_size := layer_index + 1
        num_index += layer_size
        layer_index += 1
    }
    return layer_indices
}

@(private)
print_tree :: proc(nums: [size]u64, layer_indices: [dynamic]u64) {
    for layer_index in 0..<len(layer_indices) {
        start_index := layer_indices[layer_index]
        tabs := len(layer_indices) - layer_index - 1
        for layer_index in 0..<tabs {
            fmt.print("    ")
        }
        layer_size := layer_index + 1
        for offset in 0..<layer_size {
            num := nums[start_index + cast(u64)offset]
            if num < 10 {
                fmt.print(" ")
            }
            if num < 100 {
                fmt.print(" ")
            }
            if num < 1000 {
                fmt.print(" ")
            }
            fmt.printf("%i,   ", num)
        }
        fmt.print("\n")
    }
    fmt.print("\n")
}

@(private)
get_maximum_path_sum :: proc(nums: [size]u64, debug: bool) -> u64 {
    // creates a cache that mirrors the original data structure, but each cell represents the maximum path length to get to that particular cell
    // this allows us to efficiently choose for any given un-computed cell whether to take the path from top-left or top-right
    // the result is a bottom layer with the maximum path possible to reach that bottom cell
    cache: [size]u64 = {}
    cache[0] = nums[0] // warm up cache for initial iteration
    layer_indices := get_layer_indices(nums)
    for layer_index in 0..<(len(layer_indices) - 1) { // skip last layer because the cache will fill without it
        if debug do print_tree(cache, layer_indices)
        start_index := layer_indices[layer_index]
        layer_size := cast(u64)layer_index + 1
        if debug do fmt.printfln("computing largest paths for layer %i (start_index=%i; layer_size=%i)", layer_index, start_index, layer_size)
        for offset in 0..<layer_size {
            index := start_index + offset
            value := cache[index]
            bottom_left_index := index + layer_size
            bottom_right_index := bottom_left_index + 1
            cache[bottom_left_index] = max(nums[bottom_left_index] + value, cache[bottom_left_index])
            cache[bottom_right_index] = nums[bottom_right_index] + value
        }
    }
    if debug do print_tree(cache, layer_indices)
    last_layer_start_index := layer_indices[len(layer_indices) - 1]
    if debug do fmt.printfln("last_layer_start_index=%i", last_layer_start_index)
    longest_path_length: u64 = 0
    for i in last_layer_start_index..<len(nums) {
        path_length := cache[i]
        longest_path_length = max(longest_path_length, path_length)
    }
    return longest_path_length
}

s18 :: proc(ctx: ^RunContext) -> u64 {
    return get_maximum_path_sum(nums, ctx.debug)
}
