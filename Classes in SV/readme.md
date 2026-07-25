# SystemVerilog Lab 11 - Modular Verification Components (Generator, Driver, Monitor)

This repository contains SystemVerilog source files for **Lab 11**, implementing modular testbench architecture components including transaction generators, drivers, monitors, and virtual interfaces.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`driver_class.sv`** | SystemVerilog Source | Implements the driver component responsible for driving transaction items onto the interface. |
| **`generatorclass.sv`** | SystemVerilog Source | Implements the generator class responsible for creating and randomizing transaction packets. |
| **`monitor.sv`** | SystemVerilog Source | Implements the monitor component that samples signals from the interface for verification. |
| **`testbench.sv`** | SystemVerilog Source | Top-level testbench environment coordinating verification components and running the simulation. |
| **`virtual_intf.sv`** | SystemVerilog Source | Defines virtual interfaces used by class-based verification components to connect to the hardware DUT. |

---

## 🚀 Getting Started

### Prerequisites
A SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or EDA Playground) is required to compile and execute these source files.

### Compilation & Simulation
1. Compile all source files together in your simulator in the correct dependency order (e.g., virtual interface and classes before the testbench).
2. Run the `testbench` module to execute the simulation.
