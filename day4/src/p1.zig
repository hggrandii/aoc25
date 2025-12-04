const std = @import("std");
const countLine = @import("count_line.zig").countLine;

pub fn SolveP1(allocator: std.mem.Allocator, input: []const u8) !u32 {
    var lines: std.ArrayList([]const u8) = .empty;
    defer lines.deinit(allocator);

    var line_iter = std.mem.tokenizeScalar(u8, input, '\n');
    while (line_iter.next()) |line| {
        try lines.append(allocator, line);
    }

    const grid = lines.items;
    var count: u32 = 0;

    for (grid, 0..) |row, outer_index| {
        for (row, 0..) |cell, inner_index| {
            switch (cell) {
                '.' => continue,
                '@' => {
                    var neighbors: u32 = 0;

                    if (outer_index != 0) {
                        neighbors += countLine(grid[outer_index - 1], inner_index);
                    }

                    if (outer_index != grid.len - 1) {
                        neighbors += countLine(grid[outer_index + 1], inner_index);
                    }

                    if (inner_index != 0) {
                        if (grid[outer_index][inner_index - 1] == '@') {
                            neighbors += 1;
                        }
                    }

                    if (inner_index != row.len - 1) {
                        if (grid[outer_index][inner_index + 1] == '@') {
                            neighbors += 1;
                        }
                    }

                    if (neighbors < 4) {
                        count += 1;
                    }
                },
                else => {},
            }
        }
    }

    return count;
}
