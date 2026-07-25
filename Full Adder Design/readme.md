# SystemVerilog Lab 09 - Full Adder Design & Interface Verification

This repository contains SystemVerilog source files for **Lab 09**, implementing a Full Adder hardware design along with modular interface-based verification testbenches.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`fa_design.sv`** | SystemVerilog Source | Implements the primary Full Adder hardware logic module. |
| **`fa_interface.sv`** | SystemVerilog Source | Defines the interface block and shared communication signals for the Full Adder. |
| **`fa_tb_interface.sv`** | SystemVerilog Source | Testbench utilizing virtual/direct interfaces to drive and monitor the Full Adder design. |
| **`fa_tb_manual.sv`** | SystemVerilog Source | Traditional manual testbench for verifying Full Adder functionality. |

---

## 🚀 Getting Started

### Prerequisites
A SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or EDA Playground) is required to compile and execute these files.

### Compilation & Simulation
1. Compile all source files together in your simulator.
2. Run your preferred testbench (`fa_tb_interface` or `fa_tb_manual`) to review simulation results.
