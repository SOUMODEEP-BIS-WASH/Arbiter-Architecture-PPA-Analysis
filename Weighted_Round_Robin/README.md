# Weighted Round Robin Arbiter (WRRA)

## Overview
This project implements a **4-Request Weighted Round Robin Arbiter (WRRA)** in Verilog HDL.  
Unlike standard round robin arbitration, this arbiter allocates **different service weights to each requester**, allowing higher-priority requesters to receive more grants before arbitration moves to the next requester.

This approach balances:
- Fairness
- Priority-based scheduling
- Controlled bandwidth allocation

The design was developed and analyzed using **AMD Vivado**, with emphasis on:
- Functional Verification
- Timing Analysis
- Power Analysis
- Resource Utilization (PPA Comparison)

---

## Features
- 4 requesters (`req[3:0]`)
- 4 grant outputs (`grant[3:0]`)
- Weighted arbitration scheme
- Sequential FSM-based architecture
- Fair cyclic grant scheduling
- Synthesized and implemented on FPGA using Vivado

---

## Weight Allocation
Each requester gets a different number of service cycles before rotation:

| Requester | Weight |
|----------|--------|
| CPU0 | 5 |
| CPU1 | 4 |
| CPU2 | 3 |
| CPU3 | 2 |

Example:
- CPU0 can hold grant for 5 cycles if continuously requesting
- CPU1 gets 4 cycles
- CPU2 gets 3 cycles
- CPU3 gets 2 cycles

After weight exhaustion, arbiter rotates to next active requester.

---

## Arbitration Logic
1. Check active requests.
2. Grant request based on current FSM state.
3. Maintain grant until assigned weight count completes.
4. Move to next requester in round-robin order.
5. Skip inactive requesters.

---

## FSM States

| State | Grant |
|-------|-------|
| S0 | Idle |
| S1 | CPU0 |
| S2 | CPU1 |
| S3 | CPU2 |
| S4 | CPU3 |

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
- `wrra.v` → Weighted Round Robin Arbiter design
- `tb.v` → Testbench
- `constraints.xdc` → FPGA constraints file
- `power_report.rpt` → Power analysis report
- `timing_report.rpt` → Timing analysis report
- `utilization_report.rpt` → Resource utilization report

---

## Simulation
The testbench validates:
- Continuous requests from all CPUs
- Weighted scheduling behavior
- Proper rotation after weight exhaustion
- Handling of partial requests
- Idle condition

Example simulation scenarios:
- All CPUs active (`1111`)
- Individual requester active
- Mixed request patterns
- No requests active

---

# PPA Results (Vivado)

## Power Summary

| Metric | Value |
|--------|-------|
| Total On-Chip Power | 0.076 W |
| Dynamic Power | 0.004 W |
| Static Power | 0.072 W |
| Junction Temperature | 25.4 °C |

---

## Timing Summary

| Metric | Value |
|--------|-------|
| WNS | 8.067 ns |
| TNS | 0.000 ns |
| WHS | 0.218 ns |
| THS | 0.000 ns |

✅ All timing constraints met.

---

## Utilization Summary

### Slice Logic

| Resource | Used | Available | Utilization |
|----------|------|-----------|-------------|
| Slice LUTs | 8 | 20800 | 0.04% |
| Slice Registers | 3 | 41600 | <0.01% |
| F7 Muxes | 3 | 16300 | 0.02% |

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
- Weighted arbitration improves bandwidth control.
- Provides better QoS than simple Round Robin.
- Low power overhead.
- Minimal resource utilization.
- Suitable for NoC, bus arbitration, and shared resource scheduling.

---

## Tools Used
- Verilog HDL
- AMD Vivado

---

## Applications
- Network-on-Chip (NoC)
- Shared Bus Arbitration
- Memory Access Scheduling
- Packet Routing
- Resource Allocation Systems
