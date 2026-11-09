const std = @import("std");
const rdtsc = @import("x86.zig").rdtsc;

pub fn main() noreturn {
    var last = rdtsc();
    var min_delta: u64 = std.math.maxInt(u64);
    var max_delta: u64 = 0;
    while (true) {
        const now = rdtsc();
        const delta = now - last;
        if (delta < min_delta) min_delta = delta;
        if (delta > max_delta) max_delta = delta;
        last = now;
        // Log to serial port every 10^6 iterations
    }
}
