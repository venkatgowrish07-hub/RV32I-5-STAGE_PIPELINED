# RISC-V 5-Stage Pipelined Processor on Basys3 FPGA

A complete implementation of a **32-bit pipelined RISC-V processor written in Verilog**, designed using a **5-stage pipeline architecture** and deployed on the **Basys3 (Artix-7) FPGA board**.  

The processor executes a **Fibonacci sequence program stored in instruction memory**, demonstrating instruction-level parallelism, hazard handling, and improved throughput compared to a single-cycle design.

The design incorporates **pipeline registers, forwarding logic, and hazard detection mechanisms**, ensuring correct execution of dependent instructions.

A **clock divider** is used to scale down the 100 MHz Basys3 clock, enabling step-by-step observation of pipeline execution on hardware.

The processor was **fully simulated, synthesized, and verified on FPGA hardware** using Xilinx Vivado.

---

## Project Overview

This project implements a **5-stage pipelined RISC-V CPU architecture** using Verilog HDL.  
The pipeline enables multiple instructions to be processed simultaneously, improving performance and efficiency.

The processor successfully executes a **Fibonacci program**, validating:
- Instruction decoding
- ALU operations
- Register file interactions
- Pipeline flow and hazard handling

---

## Pipeline Architecture

The processor follows the standard **5-stage RISC-V pipeline**:

1. **Instruction Fetch (IF)**  
   - Fetch instruction from instruction memory  

2. **Instruction Decode (ID)**  
   - Decode instruction  
   - Read registers from register file  

3. **Execute (EX)**  
   - Perform ALU operations  
   - Compute branch targets  

4. **Memory Access (MEM)**  
   - Read/write data memory  

5. **Write Back (WB)**  
   - Write results back to register file  

Pipeline registers are placed between each stage to store intermediate results and maintain proper synchronization.

---

## Key Features

- 32-bit **RISC-V pipelined processor**
- **5-stage pipeline (IF, ID, EX, MEM, WB)**
- Modular RTL design using **Verilog HDL**
- Core components:
  - Program Counter (PC)
  - Instruction Memory
  - Register File
  - ALU
  - Control Unit
  - Pipeline Registers
- **Hazard Handling**
  - Data Forwarding (Bypassing)
  - Stall Logic (Hazard Detection Unit)
- Execution of **Fibonacci program**
- **Clock divider** for Basys3 100 MHz clock
- Complete **simulation testbench**
- **XDC constraint file** for FPGA
- Successfully **synthesized and deployed on hardware**

---

## Design Highlights

- Demonstrates **instruction-level parallelism (ILP)**
- Improved **throughput compared to single-cycle CPU**
- Efficient handling of:
  - Data hazards
  - Control hazards
- Clean modular design for scalability

---

## Tools & Technologies

- **Verilog HDL**
- **Xilinx Vivado**
- **Basys3 FPGA (Artix-7)**

---

## Results

- Correct execution of Fibonacci sequence program
- Verified pipeline behavior through simulation and hardware testing
- Stable operation on FPGA with controlled clock execution

---

## Future Improvements

- Branch prediction unit
- Pipeline performance analysis (CPI, speedup)
- Support for more RISC-V instructions
- Cache integration
- Superscalar or out-of-order extensions

---
