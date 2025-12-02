const std = @import("std");
const part1 = @import("part1.zig");
const part2 = @import("part2.zig");

pub fn print_out(contents: []const u8) !void {
    var buffer: [4096]u8 = undefined;
    var writer_gate = std.fs.File.stdout().writer(&buffer);

    const writer = &writer_gate.interface;

    try writer.writeAll(contents);
    try writer.flush();
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    // Part 1
    {
        const contents = try part1.parse_file_p1(allocator, "data/input.txt");
        defer allocator.free(contents);

        const answer = part1.solve_p1(contents);

        std.debug.print("{d}\n", .{answer});
    }

    // Part 2
    {
        const contents2 = try std.fs.cwd().readFileAlloc(allocator, "data/input.txt", std.math.maxInt(usize));
        defer allocator.free(contents2);

        const answer2 = part2.solvePart2(contents2);
        std.debug.print("{d}\n", .{answer2});
    }
}
