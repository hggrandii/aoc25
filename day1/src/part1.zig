const std = @import("std");

pub fn parse_file_p1(allocator: std.mem.Allocator, file_path: []const u8) ![]u8 {
    var file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    return try file.readToEndAlloc(allocator, std.math.maxInt(usize));
}

pub fn solve_p1(input: []const u8) u32 {
    var count_zero: u32 = 0;
    var dial: i32 = 50;

    var it = std.mem.tokenizeScalar(u8, input, '\n');
    // var it = std.mem.tokenizeAny(u8, input, "\r\n");

    while (it.next()) |line| {
        if (line.len == 0) continue;

        const dir = line[0];
        const num = std.fmt.parseInt(i32, line[1..], 10) catch continue;

        if (dir == 'L') {
            dial = @rem(dial - num, 100);
            if (dial < 0) dial += 100;
        } else {
            dial = @rem(dial + num, 100);
            if (dial < 0) dial += 100;
        }

        if (dial == 0) {
            count_zero += 1;
        }
    }

    return count_zero;
}
