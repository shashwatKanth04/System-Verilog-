# Clock Domains & Reset Synchronization

SystemVerilog/Verilog designs covering clocking domains, asynchronous reset 
handling, and reset synchronizer implementation, with self-checking testbenches.

| File | Description |
|---|---|
| four_bit_counter.sv | 4-bit synchronous counter |
| four_bit_counter_reset_synchronizer.sv | 4-bit counter with reset synchronizer |
| johnson_counter_async_reset_n.v | Johnson Counter with active-low async reset |
| up_counter_async_reset_n.v | Up Counter with active-low async reset |
| tb_dff_register_dup.v | Testbench for DFF register |
| tb_johnson_counter_async_reset_n.v | Testbench for Johnson Counter (async reset) |
| tb_up_counter_async_reset_n.v | Testbench for Up Counter (async reset) |

**Concept covered:** Clocking domains, asynchronous reset, reset synchronization
**Status:** Includes self-checking testbenches for Johnson Counter, Up Counter, and DFF register.
