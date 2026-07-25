# SystemVerilog Lab 10 - Randomization and Constraints

This repository contains SystemVerilog source files for **Lab 10**, focusing on constrained random verification (CRV), conditional constraints, distributions, inline constraints, and constraint control methods.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`conditional_ifelse.sv`** | SystemVerilog Source | Demonstrates `if-else` conditional constraints in random classes. |
| **`conditional_implication.sv`** | SystemVerilog Source | Illustrates implication operator (`->`) usage for conditional constraint rules. |
| **`const_bidirectional.sv`** | SystemVerilog Source | Shows bidirectional constraint behavior across multiple random variables. |
| **`const_non_override.sv`** | SystemVerilog Source | Explores base constraint preservation without subclass or inline overriding. |
| **`const_override.sv`** | SystemVerilog Source | Demonstrates how constraints can be overridden or disabled in extended classes. |
| **`inline_constraint.sv`** | SystemVerilog Source | Illustrates the use of `rand_mode` and inline constraints using `with` clauses during randomization. |
| **`inside`** | SystemVerilog Source | Demonstrates the use of the `inside` operator for defining value ranges and sets. |
| **`rand_constr_mode.sv`** | SystemVerilog Source | Shows how to enable or disable specific constraints dynamically using `constraint_mode()`. |
| **`random_const.sv`** | SystemVerilog Source | Covers basic random variable declaration (`rand`, `randc`) and constraint blocks. |
| **`solve_constraint.sv`** | SystemVerilog Source | Illustrates the use of `solve ... before` constructs to control constraint solver ordering and probability distributions. |

---

## 🚀 Getting Started

### Prerequisites
A SystemVerilog-compatible simulator (such as ModelSim, Questa, VCS, or EDA Playground) supporting constrained random verification is required to compile and execute these files.

### Compilation & Simulation
1. Compile the target constraint source file in your simulator.
2. Run the simulation to view the randomized output results for each constraint mechanism.
