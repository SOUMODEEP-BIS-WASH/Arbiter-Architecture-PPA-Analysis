# Arbiter-Architecture-PPA-Analysis

A complete Verilog implementation and FPGA analysis of multiple arbitration architectures used in shared resource systems such as SoCs, NoCs, memory controllers, bus interconnects, and communication subsystems.

This repository contains RTL design, testbenches, simulation results, synthesis reports, and FPGA implementation results for various arbiter architectures.

---

# Repository Overview

This repository includes the following arbiter architectures:

* Fixed Priority Arbiter (FPA)
* Round Robin Arbiter (RRA)
* Weighted Round Robin Arbiter (WRRA)
* Tree Arbiter (TA)
* Matrix Arbiter (MA)

Each arbiter is implemented in Verilog HDL and verified through:

* Functional simulation
* Synthesis
* FPGA implementation
* Power analysis
* Timing analysis
* Resource utilization analysis

Apart from these, this repository also contains a 4x4 crossbar switch architecture.

---

# Tools Used

* **HDL Language:** Verilog
* **Simulation:** AMD Vivado
* **Synthesis & Implementation:** AMD Vivado


---

# Project Structure

```bash
├── Crossbar_Switch/
├── Fixed_Priority_Arbiter/
├── Round_Robin_Arbiter/
├── Weighted_Round_Robin_Arbiter/
├── Tree_Arbiter/
├── Matrix_Arbiter/
│
└── README.md
```

# Crossbar Switch

## Overview
A Crossbar Switch is a switching fabric used to connect multiple inputs to multiple outputs simultaneously.  
Unlike arbiters, which decide **who gets access**, a crossbar decides **how connections are routed**.

In NoC (Network-on-Chip), routers, interconnects, and memory subsystems, arbiters and crossbars often work together:

- **Arbiter** → Selects winning requester  
- **Crossbar** → Establishes the physical data path  

---

## Features
- Supports multiple simultaneous connections
- High throughput
- Low latency communication
- Common in SoC interconnects and NoC routers

---

## Crossbar vs Arbiter

| Feature | Arbiter | Crossbar |
|---------|---------|----------|
| Purpose | Select winner among requests | Route data between inputs and outputs |
| Output | Grant signals | Data path connections |
| Complexity | Low to Moderate | Moderate to High |
| Usage | Resource allocation | Switching fabric |

---

## Integration with Arbitration Logic

Typical pipeline:

Request → Arbiter → Grant → Crossbar Configuration → Data Transfer

Example:
- CPU0, CPU1 request Memory Port
- Arbiter selects CPU0
- Crossbar connects CPU0 to Memory
- Data transfer occurs

---

# 1. Fixed Priority Arbiter

## Description

Fixed Priority Arbitration grants access based on predefined priority levels.

Priority Order:

```text
REQ0 > REQ1 > REQ2 > REQ3
```

### Features

* Simple design
* Minimal hardware
* Very low latency
* Can cause starvation

### Applications

* Interrupt controllers
* Low-complexity bus arbitration

---

# 2. Round Robin Arbiter

## Description

Round Robin arbitration provides fair resource allocation by rotating priority after each grant.

### Features

* Fair scheduling
* Prevents starvation
* Moderate hardware complexity

### Applications

* Shared buses
* Network routers
* DMA controllers

---

# 3. Weighted Round Robin Arbiter

## Description

Weighted Round Robin extends Round Robin by assigning weights to requests.

Example weights:

* Request 0 → 4 cycles
* Request 1 → 3 cycles
* Request 2 → 2 cycles
* Request 3 → 1 cycle

### Features

* Fair allocation
* Priority-aware bandwidth allocation
* Good balance between complexity and performance

### Applications

* QoS systems
* NoC routers
* Packet schedulers

---

# 4. Tree Arbiter

## Description

Tree Arbiter uses hierarchical arbitration through smaller arbiters arranged in a tree structure.

Example:

```text
      Root
     /    \
   Arb1   Arb2
```

### Features

* Scalable design
* Efficient hierarchical arbitration
* Good performance

### Applications

* Large NoCs
* Multi-core processors

---

# 5. Matrix Arbiter

## Description

Matrix arbitration uses pairwise priority relationships between all requesters.

### Features

* Highly fair
* Strong dynamic priority control
* Complex logic

### Applications

* High-performance interconnects
* Advanced NoC systems

---

# Comparative PPA Analysis

This section compares all arbiter architectures using:

* Performance (Timing)
* Power
* Area (Resource Utilization)

---

# 1. Timing Comparison

| Arbiter              | WNS (ns)  | WHS (ns) | Timing Status |
| -------------------- | --------- | -------- | ------------- |
| Fixed Priority       | **8.502** | 0.261    | ✅ Met         |
| Weighted Round Robin | 8.067     | 0.218    | ✅ Met         |
| Tree Arbiter         | 7.590     | 0.202    | ✅ Met         |
| Round Robin          | 7.314     | 0.279    | ✅ Met         |
| Matrix Arbiter       | 4.939     | 0.296    | ✅ Met         |

---

# 2. Power Comparison

| Arbiter              | Total Power (W) | Dynamic Power (W) | Static Power (W) |
| -------------------- | --------------- | ----------------- | ---------------- |
| Fixed Priority       | 0.076           | 0.004             | 0.072            |
| Round Robin          | 0.076           | 0.005             | 0.072            |
| Weighted Round Robin | 0.076           | 0.004             | 0.072            |
| Tree Arbiter         | **0.075**       | **0.003**         | 0.072            |
| Matrix Arbiter       | **0.075**       | **0.003**         | 0.072            |

---

# 3. Area Comparison

| Arbiter              | LUTs Used | Registers Used |
| -------------------- | --------- | -------------- |
| Fixed Priority       | **5**     | 3              |
| Weighted Round Robin | 8         | 3              |
| Round Robin          | 18        | 5              |
| Tree Arbiter         | 35        | 18             |
| Matrix Arbiter       | **66**    | 17             |

---

# Key Observations

## Performance

* Fixed Priority Arbiter achieved the best timing performance.
* Matrix Arbiter has the lowest timing margin due to complex logic.

## Power

* All designs have nearly identical power.
* Static FPGA power dominates total power.

## Area

* Fixed Priority Arbiter is the smallest.
* Matrix Arbiter consumes the highest resources.

---

# Overall Comparison Summary

| Metric         | Best Arbiter         | Reason                  |
| -------------- | -------------------- | ----------------------- |
| Fastest Timing | Fixed Priority       | Highest WNS             |
| Lowest Power   | Tree / Matrix        | Lowest total power      |
| Smallest Area  | Fixed Priority       | Minimum LUT usage       |
| Best Fairness  | Matrix Arbiter       | Strong dynamic fairness |
| Best Tradeoff  | Weighted Round Robin | Balanced PPA            |

---

# Tradeoff Analysis

## Fixed Priority Arbiter

✔ Best timing
✔ Lowest area
✘ Starvation possible

---

## Round Robin Arbiter

✔ Fair allocation
✔ Moderate complexity

---

## Weighted Round Robin Arbiter

✔ Fair
✔ Priority-aware
✔ Excellent tradeoff

---

## Tree Arbiter

✔ Scalable
✔ Good for large systems

---

## Matrix Arbiter

✔ Best fairness
✔ Advanced arbitration
✘ Highest complexity

---

# Final Conclusion

Each arbiter offers unique tradeoffs:

* **Fixed Priority Arbiter** → Best performance and smallest area
* **Round Robin Arbiter** → Good fairness
* **Weighted Round Robin Arbiter** → Best overall tradeoff
* **Tree Arbiter** → Best scalability
* **Matrix Arbiter** → Best fairness but highest complexity

Among all architectures, the **Weighted Round Robin Arbiter** provides the best balance of:

* Performance
* Power
* Area
* Fairness

making it the most practical architecture for real-world arbitration systems.

---
