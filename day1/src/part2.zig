const std = @import("std");

pub fn solvePart2(input: []const u8) u32 {
    var count_zero: u32 = 0;
    var dial: i32 = 50;

    var it = std.mem.tokenizeScalar(u8, input, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue;

        const dir = line[0];
        const num = std.fmt.parseInt(i32, line[1..], 10) catch continue;

        switch (dir) {
            'L' => {
                count_zero += countCrossings(dial, dial - num);
                dial = @rem(dial - num, 100);
            },
            else => {
                count_zero += countCrossings(dial, dial + num);
                dial = @rem(dial + num, 100);
            },
        }

        if (dial < 0) dial += 100;
    }

    return count_zero;
}

fn countCrossings(start: i32, end: i32) u32 {
    const norm_start = @mod(@mod(start, 100) + 100, 100);
    const norm_end = @mod(@mod(end, 100) + 100, 100);

    if (norm_start == norm_end) return 0;

    const diff = end - start;

    var total: u32 = @intCast(@abs(diff) / 100);

    const remainder = @mod(@abs(diff), 100);

    const dir: i32 = if (diff > 0) 1 else -1;

    var pos = norm_start;
    var i: usize = 0;
    while (i < remainder) : (i += 1) {
        pos = pos + dir;
        if (pos == 100) pos = 0;
        if (pos == -1) pos = 99;

        if (pos == 0) total += 1;
    }

    return total;
}
