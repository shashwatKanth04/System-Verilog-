# SystemVerilog Lab 13 - MPB (Multi-Protocol Bus / Master-Protocol-Based) Verification Environment

This repository contains SystemVerilog source files for **Lab 13**, implementing a comprehensive verification environment featuring master and slave blocks, custom package files, interfaces, and a top-level testbench.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`master.sv`** | SystemVerilog Source | Implements the master verification component or bus master logic. |
| **`mpb_interface.sv`** | SystemVerilog Source | Defines the interface block and signal connections for the MPB architecture. |
| **`mpb_tb_pkg.sv`** | SystemVerilog Source | Contains testbench verification classes, transaction items, and definitions encapsulated in a package. |
| **`slave.sv`** | SystemVerilog Source | Implements the slave verification component or response logic. |
| **`top_tb.sv`** | SystemVerilog Source | Top-level integration testbench instantiating the design, interfaces, and verification components. |

---

## 🚀 Getting Started

### Prerequisites
A SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or Xcelium) supporting packages and interfaces is required to compile and execute these source files.

### Compilation & Simulation
1. Compile all source files together in your simulator (ensuring `mpb_tb_pkg.sv` is compiled first before dependent modules).
2. Run the `top_tb` testbench module to execute the simulation.
