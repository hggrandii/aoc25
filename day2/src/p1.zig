const std = @import("std");

fn isDoubleRepeated(id: u64) bool {
    var buf: [32]u8 = undefined;
    const len = std.fmt.printInt(buf[0..], id, 10, .lower, .{});
    const s = buf[0..len];

    if (@mod(len, 2) != 0) return false;

    const half = s.len / 2;

    return std.mem.eql(u8, s[0..half], s[half..]);
}

pub fn SolveP1(input: []const u8) !u64 {
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
            if (isDoubleRepeated(id)) {
                total += id;
            }
        }
    }

    return total;
}
