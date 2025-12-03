const std = @import("std");
const p1 = @import("p1.zig");
const p2 = @import("p2.zig");
const input = @embedFile("input.txt");

pub fn main() !void {

    // p1
    {
        const result = try p1.SolveP1(input);
        std.debug.print("Part 1: {}\n", .{result});
    }

    // p2
    {
        const result2 = try p2.SolveP2(input);
        std.debug.print("Part 2: {}\n", .{result2});
    }
}
