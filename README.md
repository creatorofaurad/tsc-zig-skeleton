# Freestanding TSC Cycle Timing Substrate (x86-64)

> **Zero-libc, freestanding Zig implementation of serialized hardware performance timing (`lfence; rdtsc; rdtscp`).**  
> *Extracted from the Leibniz Systems bare-metal runtime for microarchitectural jitter profiling.*

---

## 1. Overview

Standard operating system timing utilities (`clock_gettime`, `std::chrono`) introduce ring-transition overhead, page-table walks, and non-deterministic kernel preemption. 

This repository provides a freestanding, zero-dependency x86-64 Zig substrate to measure cycle-accurate execution latencies using hardware serialization barriers:

- `lfence; rdtsc`: Serializes the instruction stream before latching the core Time Stamp Counter (TSC).
- `rdtscp; lfence`: Reads the core timestamp alongside the processor core ID (`IA32_TSC_AUX`) and drains out-of-order execution pipelines before subsequent instructions retire.

---

## 2. Silicon Invariants

- **`malloc` = 0 Bytes**: Operates strictly within CPU registers and fixed stack frames.
- **Freestanding ELF**: Compiles with `-target x86_64-freestanding` without linking libc or standard runtime stubs.
- **Hardware Barrier Discipline**: Guarantees zero out-of-order instruction leakage across the measurement bracket.

---

## 3. Build & Run

```bash
zig build-exe -O ReleaseFast -target x86_64-freestanding src/main.zig
```

---
*Author: Srijan Mandal (`creatorofaurad`) | Leibniz Systems*
