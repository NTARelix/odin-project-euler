package main

import "core:fmt"
import "core:math/linalg"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:time"
import "solutions"

@(private)
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
        solutions.s01,
        solutions.s02,
        solutions.s03,
        solutions.s04,
        solutions.s05,
        solutions.s06,
        solutions.s07,
        solutions.s08,
        solutions.s09,
        solutions.s10,
        solutions.s11,
        solutions.s12,
        solutions.s13,
        solutions.s14,
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
