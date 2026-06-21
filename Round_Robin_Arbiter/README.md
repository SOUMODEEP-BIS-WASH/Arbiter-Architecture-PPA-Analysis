# Round Robin Arbiter

## Overview

This project implements a **4-Request Round Robin Arbiter** in Verilog HDL. The arbiter grants access among four CPU request lines using a fair scheduling policy.

Unlike fixed priority arbitration, this design prevents starvation by rotating access among requesters. Each CPU is allowed to hold the grant for a maximum of **3 clock cycles**, after which priority moves to the next active requester.

The design was implemented and analyzed using **AMD Vivado** for functional verification and FPGA-based PPA (Power, Performance, Area) evaluation.

---

## Features

* 4 CPU request inputs (`req[3:0]`)
* 4 grant outputs (`grant[3:0]`)
* Round Robin scheduling policy
* Maximum grant duration of 3 cycles per requester
* Prevents starvation
* Fair resource allocation
* FPGA implementation with synthesis reports

---

## Arbitration Policy

* CPU0 → First priority in initial cycle
* CPU1 → Next
* CPU2 → Next
* CPU3 → Last

Once a CPU is granted:

* It can retain access for **up to 3 cycles**
* After 3 cycles, grant rotates to the next active requester
* If no other request exists, current requester continues

This ensures fairness while maintaining efficient utilization.

---

## State Machine

The arbiter uses a 5-state FSM:

* **S0** → Idle state
* **S1** → CPU0 granted
* **S2** → CPU1 granted
* **S3** → CPU2 granted
* **S4** → CPU3 granted

State transitions depend on:

* Active request lines
* Internal grant counter

---

## Files Included

* `RRA.v` → Round Robin Arbiter design module
* `tb.v` → Testbench for simulation
* `constraints.xdc` → FPGA constraints file
* `power_report.rpt` → Power analysis report
* `timing_report.rpt` → Timing analysis report
* `utilization_report.rpt` → Resource utilization report

---

## Inputs and Outputs

### Inputs

| Signal | Width | Description       |
| ------ | ----- | ----------------- |
| clk    | 1     | System clock      |
| rst    | 1     | Reset             |
| req    | 4     | CPU request lines |

### Outputs

| Signal | Width | Description |
| ------ | ----- | ----------- |
| grant  | 4     | Grant lines |

---

## Simulation

The testbench verifies:

* Reset behavior
* Continuous requests from all CPUs
* Fair rotation of grants
* Individual requester scenarios
* Mixed request patterns

### Example Grant Rotation

```text
REQ = 1111

Cycle 1-3   -> CPU0 granted
Cycle 4-6   -> CPU1 granted
Cycle 7-9   -> CPU2 granted
Cycle 10-12 -> CPU3 granted
```

---

## FPGA Implementation

Targeted on FPGA using Vivado with timing constraints and synthesis analysis.

---

# PPA Results

## Power Report

| Metric              | Value   |
| ------------------- | ------- |
| Total On-Chip Power | 0.076 W |
| Dynamic Power       | 0.005 W |
| Static Power        | 0.072 W |

---

## Timing Report

| Metric | Value    |
| ------ | -------- |
| WNS    | 7.314 ns |
| TNS    | 0.000 ns |
| WHS    | 0.279 ns |

**Result:** All timing constraints met.

---

## Utilization Report

### Slice Logic

| Resource        | Used | Available | Utilization |
| --------------- | ---- | --------- | ----------- |
| Slice LUTs      | 18   | 20800     | 0.09%       |
| Slice Registers | 5    | 41600     | 0.01%       |
| F7 Muxes        | 3    | 16300     | 0.02%       |

### Clocking

| Resource | Used | Available |
| -------- | ---- | --------- |
| BUFGCTRL | 1    | 32        |

---

## Comparison with Priority Arbiter

| Metric        | Priority Arbiter | Round Robin Arbiter |
| ------------- | ---------------- | ------------------- |
| LUTs          | 5                | 18                  |
| Registers     | 3                | 5                   |
| Dynamic Power | 0.004 W          | 0.005 W             |
| WNS           | 8.502 ns         | 7.314 ns            |

### Observation

* Round Robin arbiter consumes more resources due to fairness logic and grant counter.
* Slightly higher dynamic power than fixed priority arbiter.
* Reduced timing slack because of more complex decision logic.
* Provides significantly better fairness and eliminates starvation.

---

## Applications

* Bus arbitration
* Shared memory access
* NoC routers
* Multi-core processors
* Communication controllers

---

## Conclusion

The Round Robin Arbiter improves fairness over fixed-priority arbitration by rotating grants among requesters. Although this comes at a slight cost in power, area, and timing performance, it offers significantly better resource sharing and starvation prevention in multi-master systems.
