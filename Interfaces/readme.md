# SystemVerilog Interfaces Lab

This repository contains a SystemVerilog project demonstrating the use of **Interfaces** for communication between master and slave modules.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`interface_signal.sv`** | SystemVerilog Source | Defines the interface block containing shared signals used to connect modules. |
| **`mastermod.sv`** | SystemVerilog Source | Implements the master module that initiates communication or drives signals. |
| **`slavemod.sv`** | SystemVerilog Source | Implements the slave module that responds to the master component. |
| **`test.sv`** | SystemVerilog Source | Top-level testbench module used to instantiate components and run simulations. |

---

## 🚀 Getting Started

### Prerequisites
You will need a SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or EDA Playground) to compile and run these source files.

### Compilation & Simulation
1. Compile all source files together in your preferred simulator tool.
2. Run the top-level testbench module (`test`) to verify functionality.
