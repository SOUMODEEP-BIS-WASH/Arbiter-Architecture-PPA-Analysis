# Tree Arbiter

## Overview
This project implements a **4-Request Tree Arbiter (TA)** in Verilog HDL using a hierarchical arbitration structure.  
Instead of handling all requests in a single arbitration stage, the requests are divided into smaller groups and resolved through multiple levels of arbitration.

The design uses:
- Two lower-level 2-input arbiters
- One upper-level 2-input arbiter

This hierarchical structure improves scalability and reduces arbitration complexity for larger systems.

The design was developed and analyzed using **AMD Vivado**, focusing on:
- Functional Verification
- Timing Analysis
- Power Analysis
- Resource Utilization (PPA Comparison)

---

## Features
- 4 requesters (`req[3:0]`)
- 4 grant outputs (`grant[3:0]`)
- Hierarchical tree-based arbitration
- Modular design using reusable 2-input arbiters
- Suitable for scalable arbitration architectures
- Synthesized and implemented in Vivado

---

## Architecture
The Tree Arbiter is organized in two stages:

### Stage 1
Two 2-input arbiters resolve:
- Arbiter A1 → CPU0 vs CPU1
- Arbiter A2 → CPU2 vs CPU3

### Stage 2
A third arbiter resolves:
- Winner of A1 vs Winner of A2

Final grant is assigned to one requester.

---

## Arbitration Flow
1. Divide requests into two groups.
2. Resolve local winner in each group.
3. Pass winners to top-level arbiter.
4. Final arbiter selects global winner.
5. Grant assigned to winning requester.

---

## Inputs and Outputs

### Inputs
| Signal | Width | Description |
|--------|-------|-------------|
| clk | 1 | Clock |
| rst | 1 | Reset |
| req | 4 | Request inputs |

### Outputs
| Signal | Width | Description |
|--------|-------|-------------|
| grant | 4 | Grant outputs |

---

## Files Included
- `ta.v` → Tree Arbiter design
- `arb2_1.v` → 2-input arbiter module
- `tb.v` → Testbench
- `constraints.xdc` → FPGA constraints file
- `power_report.rpt` → Power report
- `timing_report.rpt` → Timing report
- `utilization_report.rpt` → Utilization report

---

## Simulation
The testbench validates:
- Simultaneous multiple requests
- Hierarchical arbitration behavior
- Correct grant selection
- Mixed request patterns
- Idle condition

Example scenarios:
- All requests active (`1111`)
- Single requester active
- Alternating request patterns
- No active requests

---

# PPA Results (Vivado)

## Power Summary

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.075 W |
| Dynamic Power | 0.003 W |
| Static Power | 0.072 W |
| Junction Temperature | 25.4 °C |

---

## Timing Summary

| Metric | Value |
|--------|-------|
| WNS | 7.590 ns |
| TNS | 0.000 ns |
| WHS | 0.202 ns |
| THS | 0.000 ns |

✅ All timing constraints met.

---

## Utilization Summary

### Slice Logic

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 35 | 20800 | 0.17% |
| Slice Registers | 18 | 41600 | 0.04% |

### IO Utilization

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Bonded IOB | 10 | 106 | 9.43% |

### Clock Resources

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| BUFGCTRL | 1 | 32 | 3.13% |

---

## Key Observations
- Tree-based arbitration improves scalability.
- Suitable for larger arbitration networks.
- Lower dynamic power than most FSM-based arbiters.
- Higher resource usage due to multi-stage arbitration.
- Effective for hierarchical interconnects and NoC routing.

---

## Tools Used
- Verilog HDL
- AMD Vivado

---

## Applications
- Network-on-Chip (NoC)
- Scalable Arbitration Networks
- Packet Switches
- Memory Controllers
- Multi-Core Resource Allocation
