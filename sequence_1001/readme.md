# Sequence Detector – "1001"

A Verilog Finite State Machine (FSM) that detects the bit pattern **1001** 
in a serial input stream.

## Design Details
- **Input:** Serial bit stream (`din`), clock (`clk`), reset (`rst`)
- **Output:** Detection signal (`y` / `detected`) — asserted high when the 
  sequence "1001" is found
- **States:** 5 states (S0 → S1 → S2 → S3 → S4), representing progress 
  through matching the sequence
- **FSM type:** [Moore / Mealy] *(update based on your actual design)*
- **Overlap handling:** [Overlapping / Non-overlapping] detection 
  *(update based on your actual design — e.g. after detecting "1001", 
  does it restart checking from the last "1", or start fresh?)*

## File
| File | Description |
|---|---|
| seq_detector_1001.v | FSM-based detector for the sequence 1001 |

**Concept covered:** Finite State Machine design, sequence detection,
