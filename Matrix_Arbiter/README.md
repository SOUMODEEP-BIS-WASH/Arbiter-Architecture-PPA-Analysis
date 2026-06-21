# Project 6: Matrix Arbiter

## Overview
This project implements a **4-request Matrix Arbiter** in Verilog HDL.  
A Matrix Arbiter uses pairwise priority relationships between requesters to determine which requester gets access to a shared resource.

Unlike fixed-priority or round-robin arbiters, the Matrix Arbiter dynamically updates priority relationships after grant cycles, improving fairness while maintaining high-speed arbitration.

This design supports:
- 4 request inputs (`req[3:0]`)
- 4 grant outputs (`grant[3:0]`)
- Dynamic priority matrix updates
- Fair arbitration among competing requesters

---

## Features
- 4-input arbitration logic
- Dynamic pairwise priority matrix
- Fair access distribution
- FSM-based control logic
- Grant hold for configurable cycles
- Synthesizable Verilog design


---

## Design Description

The arbiter uses:
- Request lines: `req[3:0]`
- Grant lines: `grant[3:0]`
- Internal matrix weights:
  - `w01`
  - `w02`
  - `w03`
  - `w12`
  - `w13`
  - `w23`

These weights define relative priorities between requesters.

### Arbitration Principle
- If multiple requests arrive simultaneously, the matrix determines priority.
- The winning requester receives grant.
- After a grant completes, matrix entries are updated.
- Priority is adjusted to ensure fairness.

---

## State Machine

States:
- `S0` → Idle
- `S1` → Grant Requester 0
- `S2` → Grant Requester 1
- `S3` → Grant Requester 2
- `S4` → Grant Requester 3

---

## Files Included

- `ma.v` → Matrix Arbiter RTL Design
- `tb.v` → Testbench
- `constraints.xdc` → FPGA Constraints
- Utilization report
- Timing report
- Power report

---

## Simulation

### Test Cases
- All requesters active simultaneously
- Single requester active
- Sequential requests
- Arbitration fairness validation

Example stimulus:
```verilog
rst=1; req=4'b1111; #10;

rst=0; req=4'b1111; #10;
rst=0; req=4'b1000; #10;
rst=0; req=4'b0100; #10;
rst=0; req=4'b0010; #10;
rst=0; req=4'b0001; #10;
```

---

## FPGA Constraints

### Clock
- Clock Frequency: **100 MHz**
- Clock Period: **10 ns**

### Pin Assignments

| Signal | Pin |
|--------|-----|
| clk | W5 |
| rst | V17 |
| req[3] | V16 |
| req[2] | W16 |
| req[1] | W17 |
| req[0] | W15 |
| grant[3] | U16 |
| grant[2] | E19 |
| grant[1] | U19 |
| grant[0] | V19 |

---

## Timing Summary

| Metric | Value |
|--------|-------|
| WNS | 4.939 ns |
| TNS | 0.000 ns |
| WHS | 0.296 ns |
| THS | 0.000 ns |

✅ All timing constraints met.

---

## Power Summary

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.075 W |
| Dynamic Power | 0.003 W |
| Static Power | 0.072 W |
| Junction Temperature | 25.4°C |

---

## Resource Utilization

### Slice Logic

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 66 | 20800 | 0.32% |
| Slice Registers | 17 | 41600 | 0.04% |

---

### IO Utilization

| Resource | Used | Available |
|----------|------|-----------|
| Bonded IOB | 10 | 106 |

---

### Clock Resources

| Resource | Used | Available |
|----------|------|-----------|
| BUFGCTRL | 1 | 32 |

---

## Results
- Successful simulation in Vivado
- Correct arbitration behavior verified
- Fair resource allocation achieved
- Low power consumption
- Minimal FPGA resource usage

---

## Tools Used
- Verilog HDL
- AMD Vivado

---

## Applications
- Bus arbitration
- Network routers
- Shared memory systems
- NoC (Network-on-Chip)
- Multi-core processors

---
