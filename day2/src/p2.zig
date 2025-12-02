const std = @import("std");

fn isRepeatedAtLeastTwice(id: u64) bool {
    var buf: [32]u8 = undefined;
    const len = std.fmt.printInt(buf[0..], id, 10, .lower, .{});
    const s = buf[0..len];

    var k: usize = 1;
    while (k <= s.len / 2) : (k += 1) {
        if (@mod(s.len, k) != 0) continue;

        const repeats = s.len / k;
        if (repeats < 2) continue;

        const chunk = s[0..k];

        var valid = true;
        var i: usize = k;
        while (i < s.len) : (i += k) {
            if (!std.mem.eql(u8, chunk, s[i .. i + k])) {
                valid = false;
                break;
            }
        }

        if (valid) return true;
    }

    return false;
}

pub fn SolveP2(input: []const u8) !u64 {
    var it = std.mem.tokenizeScalar(u8, input, ',');

    var total: u64 = 0;

    while (it.next()) |range_raw| {
        const range_str = std.mem.trim(u8, range_raw, " \t\r\n");
        if (range_str.len == 0) continue;

        var dash_it = std.mem.tokenizeScalar(u8, range_str, '-');
        const start_str = dash_it.next() orelse continue;
        const end_str = dash_it.next() orelse continue;

        const start = try std.fmt.parseUnsigned(u64, start_str, 10);
        const end = try std.fmt.parseUnsigned(u64, end_str, 10);

        var id = start;
        while (id <= end) : (id += 1) {
            if (isRepeatedAtLeastTwice(id)) {
                total += id;
            }
        }
    }

    return total;
}
