pub inline fn rdtsc() u64 {
    var low: u32 = undefined;
    var high: u32 = undefined;
    asm volatile (
        \\rdtscp
        : [low] "={eax}" (low),
          [high] "={edx}" (high),
        :
        : "rcx"
    );
    return (@as(u64, high) << 32) | @as(u64, low);
}
