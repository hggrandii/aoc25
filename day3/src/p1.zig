const std = @import("std");

pub fn SolveP1(input: []const u8) !u32 {
    var total: u32 = 0;
    var lines = std.mem.tokenizeScalar(u8, input, '\n');

    while (lines.next()) |line| {
        const max_joltage = findMaxJoltage(line);
        total += max_joltage;
    }

    return total;
}

fn findMaxJoltage(bank: []const u8) u32 {
    var max: u32 = 0;

    for (bank, 0..) |first_char, i| {
        if (!std.ascii.isDigit(first_char)) continue;

        for (bank[i + 1 ..]) |second_char| {
            if (!std.ascii.isDigit(second_char)) continue;

            const first_digit = first_char - '0';
            const second_digit = second_char - '0';
            const joltage = first_digit * 10 + second_digit;

            if (joltage > max) {
                max = joltage;
            }
        }
    }
    return max;
}
