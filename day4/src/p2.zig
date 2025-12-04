const std = @import("std");
const countLine = @import("count_line.zig").countLine;

pub fn SolveP2(allocator: std.mem.Allocator, input: []const u8) !u32 {
    var lines: std.ArrayList([]const u8) = .empty;
    defer lines.deinit(allocator);

    var line_iter = std.mem.tokenizeScalar(u8, input, '\n');
    while (line_iter.next()) |line| {
        try lines.append(allocator, line);
    }

    var grid: std.ArrayList(std.ArrayList(u8)) = .empty;
    defer {
        for (grid.items) |*row| {
            row.deinit(allocator);
        }
        grid.deinit(allocator);
    }

    for (lines.items) |line| {
        var row: std.ArrayList(u8) = .empty;
        for (line) |char| {
            try row.append(allocator, char);
        }
        try grid.append(allocator, row);
    }

    var total: u32 = 0;
    var used: std.ArrayList([2]usize) = .empty;
    defer used.deinit(allocator);

    var going = true;
    while (going) {
        var count: u32 = 0;

        for (grid.items, 0..) |row, outer_index| {
            for (row.items, 0..) |cell, inner_index| {
                switch (cell) {
                    '.' => continue,
                    '@' => {
                        var neighbors: u32 = 0;

                        if (outer_index != 0) {
                            neighbors += countLine(grid.items[outer_index - 1].items, inner_index);
                        }

                        if (outer_index != grid.items.len - 1) {
                            neighbors += countLine(grid.items[outer_index + 1].items, inner_index);
                        }

                        if (inner_index != 0) {
                            if (grid.items[outer_index].items[inner_index - 1] == '@') {
                                neighbors += 1;
                            }
                        }

                        if (inner_index != row.items.len - 1) {
                            if (grid.items[outer_index].items[inner_index + 1] == '@') {
                                neighbors += 1;
                            }
                        }

                        if (neighbors < 4) {
                            count += 1;
                            try used.append(allocator, .{ outer_index, inner_index });
                        }
                    },
                    else => {},
                }
            }
        }

        if (count == 0) {
            going = false;
        }

        total += count;

        for (used.items) |pos| {
            grid.items[pos[0]].items[pos[1]] = '.';
        }

        used.clearRetainingCapacity();
    }

    return total;
}
