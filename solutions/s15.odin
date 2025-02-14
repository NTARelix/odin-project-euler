package solutions

import "core:fmt"

@(private)
lattice_cell_size :: 20

@(private)
lattice_intersection_size :: lattice_cell_size + 1

@(private)
lattice_cache_count :: lattice_intersection_size * lattice_intersection_size

@(private)
LatticeCache :: [lattice_cache_count]u64

@(private)
get_value :: proc(cache: ^LatticeCache, x: u64, y: u64) -> u64 {
    return cache[x + (y * lattice_intersection_size)]
}

@(private)
set_value :: proc(cache: ^LatticeCache, x: u64, y: u64, value: u64) {
    cache[x + (y * lattice_intersection_size)] = value
}

@(private)
get_lattice_path_count :: proc(cache: ^LatticeCache, size: u64, x: u64, y: u64, debug: bool) -> u64 {
    if debug {
        fmt.printfln("(%i, %i)", x, y)
        print_lattice_cache(cache)
    }
    count: u64 = 0
    if x == size && y == size {
        count = 1
    } else if get_value(cache, x, y) != 0 {
        count = get_value(cache, x, y)
    } else {
        if x != size {
            count += get_lattice_path_count(cache, size, x + 1, y, debug)
        }
        if y != size {
            count += get_lattice_path_count(cache, size, x, y + 1, debug)
        }
    }
    set_value(cache, x, y, count)
    return count
}

@(private)
print_lattice_cache :: proc(cache: ^LatticeCache) {
    for y in cast(u64)0..=lattice_cell_size {
        first_value := get_value(cache, 0, y)
        if first_value < 10 {
            fmt.print(" ")
        }
        fmt.printf("%i", first_value)
        for x in cast(u64)1..=lattice_cell_size {
            fmt.print("-")
            value := get_value(cache, x, y)
            // left pad
            if value < 10 { // TODO: scale this depending on largest number in the lattice
                fmt.print("-")
            }
            fmt.printf("%i", value)
        }
        if y < lattice_cell_size {
            fmt.print("\n |")
            for x in 1..=lattice_cell_size {
                fmt.print("  |")
            }
        }
        fmt.print("\n")
    }
    fmt.print("\n")
}

s15 :: proc(ctx: ^RunContext) -> u64 {
    lattice_cache: LatticeCache = {}
    count := get_lattice_path_count(&lattice_cache, lattice_cell_size, 0, 0, ctx.debug)
    if ctx.debug {
        print_lattice_cache(&lattice_cache)
    }
    return count
}
