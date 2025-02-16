package main

import "core:fmt"
import "core:math/linalg"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:time"
import "solutions"

@(private)
run_solution :: proc(ctx: ^solutions.RunContext, num: u64, solution: proc(^solutions.RunContext) -> u64) {
    if ctx.solution_to_run != 0 && num != ctx.solution_to_run {
        return
    }
    stopwatch: time.Stopwatch
    time.stopwatch_start(&stopwatch)
    result := solution(ctx)
    time.stopwatch_stop(&stopwatch)
    dur_ms := cast(f64)time.stopwatch_duration(stopwatch) / cast(f64)time.Millisecond
    fmt.printfln("Solution %i (%f ms): %i", num, dur_ms, result)
}

main :: proc() {
    all_solutions := []proc(^solutions.RunContext) -> u64{
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
        solutions.s15,
        solutions.s16,
        solutions.s17,
        solutions.s18,
    }
    ctx: solutions.RunContext = {
        solution_to_run = 0,
    }
    for arg in os.args[1:] {
        solution_to_run: int
        if parsed, ok := strconv.parse_int(arg); ok {
            solution_to_run = parsed
            if solution_to_run > 0 {
                ctx.solution_to_run = cast(u64)solution_to_run
            } else if solution_to_run < 0 {
                ctx.solution_to_run = cast(u64)(len(all_solutions) + solution_to_run + 1)
            }
        } else if arg == "-d" || arg == "--debug" {
            ctx.debug = true
        } else {
            fmt.printfln("failed to parse first parameter as int: %s", os.args[1])
            return
        }
    }
    for i in 0..<len(all_solutions) {
        run_solution(&ctx, cast(u64)i + 1, all_solutions[i])
    }
}
