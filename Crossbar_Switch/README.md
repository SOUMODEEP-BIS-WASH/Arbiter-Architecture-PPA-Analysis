# 4×4 Crossbar Switch in Verilog

## Overview
This project implements a **4×4 Crossbar Switch** in Verilog.  
The crossbar routes data from one of four input sources to one of four output destinations based on:
- **Grant signals** (from an arbiter)
- **Destination selection signals**

This design models a simple switching fabric commonly used in:
- Network-on-Chip (NoC)
- Bus interconnects
- Routers
- Memory access networks

---

## Features
- 4 input ports
- 4 output ports
- 8-bit data width
- Grant-based input selection
- Destination-based routing
- Output valid signaling
- Fully combinational design

---

## Architecture

### Inputs
| Signal | Width | Description |
|--------|-------|-------------|
| `in_valid` | 4 | Valid signal for each input |
| `grant` | 4 | Grant signal from arbiter |
| `dest1-dest4` | 2 each | Destination output selection |
| `datain1-datain4` | 8 each | Input data |

---

### Outputs
| Signal | Width | Description |
|--------|-------|-------------|
| `dataout1-dataout4` | 8 each | Routed output data |
| `out_valid` | 4 | Output validity indicator |

---

## Working Principle

Each input port has:
- Data input
- Valid signal
- Destination selection

The arbiter provides a one-hot `grant` signal indicating which input gets access to the crossbar.

Example:
- If `grant = 4'b0001`, Input 1 is selected.
- If `dest1 = 2'b10`, data from Input 1 is routed to Output 3.

---

## Routing Table

| Destination | Output Port |
|-------------|-------------|
| `00` | Output 1 |
| `01` | Output 2 |
| `10` | Output 3 |
| `11` | Output 4 |

---

## Module Description

### Crossbar Module
Implements routing logic based on:
- Grant priority
- Destination select

Routing priority:
1. Input 1
2. Input 2
3. Input 3
4. Input 4

Only one granted input is routed at a time.

---

### Testbench
The testbench verifies:
- All four input sources
- All four output destinations
- Correct routing behavior
- Correct output valid generation

Simulation includes multiple routing scenarios such as:
- Input 1 → Output 1
- Input 1 → Output 2
- Input 3 → Output 4
- Input 4 → Output 3
- Input 2 → Output 1

---

## Example

### Input
```verilog
grant   = 4'b0001;
in_valid= 4'b0001;
dest1   = 2'b10;
datain1 = 8'd8;
```

### Output
```verilog
dataout3 = 8'd8;
out_valid = 4'b0100;
```

---

## Simulation Tool
- AMD Vivado

---

## Applications
- NoC routing
- Bus switching
- Interconnect fabrics
- CPU-to-memory routing
- Multi-master communication systems

---

---

## Author
Soumodeep Biswash
