# SystemVerilog Lab 06 - Advanced Interfaces & Testbenches

This repository contains SystemVerilog source files for **Lab 06**, featuring modular master-slave architectures, interface signal definitions, and multiple testbench layers.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`interface_signal.sv`** | SystemVerilog Source | Defines the interface block and shared communication signals. |
| **`mastermod.sv`** | SystemVerilog Source | Implements the primary master module logic. |
| **`mastermod_tb.sv`** | SystemVerilog Source | Dedicated testbench for verifying the master module independently. |
| **`slavemod.sv`** | SystemVerilog Source | Implements the slave module responding to the master component. |
| **`top.sv`** | SystemVerilog Source | Top-level integration module connecting master, slave, and interfaces. |
| **`top_tb.sv`** | SystemVerilog Source | Standard top-level testbench for running full system simulations. |
| **`top_tb_new.sv`** | SystemVerilog Source | Alternative or updated top-level testbench version. |

---

## 🚀 Getting Started

### Prerequisites
A SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or EDA Playground) is required to compile and execute these files.

### Compilation & Simulation
1. Compile all source files together in your simulator.
2. Run your preferred testbench (`top_tb`, `top_tb_new`, or `mastermod_tb`) to check simulation results.
