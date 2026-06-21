# Priority Arbiter

## Overview

This project implements a **4-input Fixed Priority Arbiter** in Verilog HDL.

The arbiter grants access to one requester at a time using a predefined priority order:

* CPU0 → Highest Priority
* CPU1 → Second Priority
* CPU2 → Third Priority
* CPU3 → Lowest Priority

The design was implemented and analyzed in **Xilinx Vivado** for functional verification and PPA (Power, Performance, Area) evaluation.

---

## Features

* 4 request inputs
* 4 grant outputs
* Fixed priority arbitration
* FSM-based design
* Low resource utilization
* Low power consumption

---

## Arbitration Logic

Priority order:

CPU0 > CPU1 > CPU2 > CPU3

Example grant behavior:

| Request | Grant |
| ------- | ----- |
| 1111    | 0001  |
| 1110    | 0010  |
| 1100    | 0100  |
| 1000    | 1000  |

---

## Files Included

* `PA.v` → Priority Arbiter design
* `tb.v` → Testbench
* `constraints.xdc` → Vivado constraints
* `power_report.rpt` → Power report
* `timing_report.rpt` → Timing report
* `utilization_report.rpt` → Utilization report

---

## Simulation

The testbench verifies:

* Multiple simultaneous requests
* Single request scenarios
* Priority enforcement
* Reset behavior

Sample output:

```text
REQ = 1111 → GRANT = 0001
REQ = 1110 → GRANT = 0010
REQ = 1100 → GRANT = 0100
REQ = 1000 → GRANT = 1000
```

---

## Timing Summary

| Metric | Value    |
| ------ | -------- |
| WNS    | 8.502 ns |
| TNS    | 0.000 ns |
| WHS    | 0.261 ns |
| THS    | 0.000 ns |

All timing constraints were successfully met.

---

## Power Summary

| Metric        | Value   |
| ------------- | ------- |
| Total Power   | 0.076 W |
| Dynamic Power | 0.004 W |
| Static Power  | 0.072 W |

---

## Utilization Summary

| Resource        | Used | Utilization |
| --------------- | ---- | ----------- |
| Slice LUTs      | 5    | 0.02%       |
| Slice Registers | 3    | <0.01%      |
| Bonded IOB      | 10   | 9.43%       |

---

## Advantages

* Fast arbitration
* Simple hardware
* Very low area overhead
* Low power consumption

---

## Limitation

Fixed priority arbitration may cause starvation for low-priority requesters.
