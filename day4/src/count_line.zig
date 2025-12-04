const std = @import("std");

pub fn countLine(line: []const u8, index: usize) u32 {
    var count: u32 = 0;

    if (index != 0) {
        if (line[index - 1] == '@') {
            count += 1;
        }
    }

    if (index != line.len - 1) {
        if (line[index + 1] == '@') {
            count += 1;
        }
    }

    if (line[index] == '@') {
        count += 1;
    }

    return count;
}
