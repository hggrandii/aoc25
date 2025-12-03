const std = @import("std");

pub fn SolveP2(input: []const u8) !u128 {
    var total: u128 = 0;
    var lines = std.mem.tokenizeScalar(u8, input, '\n');

    while (lines.next()) |line| {
        total += findMaxJoltage(line);
    }

    return total;
}

fn findMaxJoltage(bank: []const u8) u128 {
    if (bank.len == 0) return 0;

    var result: u128 = 0;
    var start_pos: usize = 0;

    for (0..12) |i| {
        const remaining = 12 - i;
        const search_end = bank.len - remaining + 1;

        var best: u8 = 0;
        var best_idx: usize = start_pos;

        for (start_pos..search_end) |j| {
            const digit = switch (bank[j]) {
                '0'...'9' => |c| c - '0',
                else => continue,
            };

            if (digit > best) {
                best = digit;
                best_idx = j;
            }
        }

        result = result * 10 + best;
        start_pos = best_idx + 1;
    }

    return result;
}
