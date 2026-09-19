# CPU

This project implements a custom 16-bit instruction set architecture (ISA), from software reference modelling through to a five-stage pipelined SystemVerilog implementation and deployment on an FPGA. Auxiliary programs include a C assembler for converting assembly programs into hexadecimal, which the SystemVerilog code can subsequently read, and C reference model for verification.

## Architecture Overview

The processor contains eight 16-bit general-purpose registers and separate instruction and data memories, each organized as 4096 × 16 bits. 

For R-type instructions, it has a 4-bit opcode, then subsequently 3 bit fields for the source register, target register and destination register, with 3 bits unused. For I-type and branch-type instructions, it has a 4-bit opcode, 3-bit fields for the source register and target register, and a 6-bit immediate field. For jump-type instructions, it has a 4-bit opcode, then a 12-bit address field.

The CPU possesses a 5-stage pipeline, with IF/ID, ID/EX, EX/MEM, MEM/WB registers. This was done to increase throughput, as introducing stages breaks the original combinational datapath into shorter paths, hence enabling a higher maximum clock frequency to be achieved. However, this does increase the latency of each individual instruction.

A pipelined CPU will have to contend with data hazards, control hazards, and structural hazards. Structural hazards have been eliminated simply by separating the instruction memory and data memory. Because instructions execute and complete in order, the pipeline does not introduce WAR or WAW hazards; the relevant register data hazards are RAW dependencies. When possible, the forwarding unit forwards relevant results to prevent the pipeline from stalling, for example EX->EX hazards, MEM->EX hazards and store-data hazards. However, for load-use hazards, forwarding is not possible so the hazard unit detects this and stalls the pipeline. The hazard unit independently manages control hazards, where branches are assumed not to be taken and instructions are subsequently flushed from the pipeline if indeed the branch condition is met.

## Repository Structure

| Path | Description |
|---|---|
| `rtl/` | Synthesizable SystemVerilog RTL for the processor and its constituent modules. |
| `assembler/` | C assembler and architectural reference-model source code. |
| `programs/` | Assembly programs and generated hexadecimal machine-code images used for testing. |
| `reference_model/` | Files for golden C simulator. |
| `tb/` | SystemVerilog testbenches for individual modules and the complete processor. |
| `waves/` | VCD waveform files generated during simulation and viewable with Surfer. |
| `build/` | Generated build artifacts, including Verilator-generated C++/executables, the compiled C assembler, and other intermediate outputs. This directory can be regenerated and is not part of the RTL source. |
| `Makefile` | Automates assembler compilation, simulation, individual tests, and regression testing. |

## Instruction Set Architecture

| Instruction | Format | Operation | Description |
|---|---|---|---|
| `ADD` | `ADD rd, rt, rs` | `ALU_ADD` | Adds the source and target operands and writes the result to the destination register. |
| `SUB` | `SUB rd, rt, rs` | `ALU_SUB` | Subtracts the source operand from the target operand and writes the result to the destination register. |
| `AND` | `AND rd, rt, rs` | `ALU_AND` | Performs a bitwise AND. |
| `OR` | `OR rd, rt, rs` | `ALU_OR` | Performs a bitwise OR. |
| `XOR` | `XOR rd, rt, rs` | `ALU_XOR` | Performs a bitwise XOR. |
| `LOAD` | `LOAD rt, offset(rs)` | `ALU_ADD` | Loads a value from data memory into `rt`. |
| `LOADI` | `LOADI rt, immediate` | `ALU_ADD` | Loads an immediate value into `rt`. |
| `STORE` | `STORE rt, offset(rs)` | `ALU_ADD` | Stores the value in `rt` to data memory. |
| `BEQ` | `BEQ rt, rs, branch` | Comparison | Branches when `rt == rs`. |
| `BNE` | `BNE rt, rs, branch` | Comparison | Branches when `rt != rs`. |
| `JMP` | `JMP address` | PC redirect | Redirects execution to the specified address. |
| `HALT` | `HALT` | Halt | Stops instruction execution and flushes younger instructions. |
| `NOP` | `NOP` | No operation | No operation occurs. |

## Instruction Encoding

R-type:
4-bit/3-bit/3-bit/3-bit/3-bit
[ opcode | rs | rt | rd | unused ]

I-type/Branch-type:
4-bit/3-bit/3-bit/6-bit
[ opcode | rs | rt | immediate ]

Jump-type:
4-bit/12-bit
[ opcode | address ]

## C Assembler

Reads assembly code file and dynamically allocates strings of assembly code. Each line is then split into tokens.
It is first separated by finding a colon, as this splits the label from the actual instruction. The rest of the line
is split in accordance with commas to assign registers, immediate values, addresses etc. After being parsed,
the labels are assigned a location counter value for future reference for branch-type and jump-type instructions.
The mnemonic of each line is checked and then is assembled in accordance with whether the mnemonic corresponds to
an R-type, I-type, Branch-type, or Jump-type instruction. The hexadecimal code then produced is stored in an output file 
which the SystemVerilog code reads from.

## C Reference Model

The C reference model provides an architectural implementation of the ISA for functional verification. Instructions execute sequentially using a basic fetch-decode-execute model rather than reproducing the pipelined microarchitecture of the SystemVerilog processor.

## Building
```bash
make assembler
```

### Assembling a Program

```bash
./build/assembler programs/test_alu
```

This converts:

programs/test_alu.asm

to:

programs/test_alu.hex

## SystemVerilog Implementation

### Pipeline

IF → IF/ID → ID → ID/EX → EX → EX/MEM → MEM → MEM/WB → WB

Instruction Fetch (IF) - Program counter is updated and fetches instruction from instruction memory which is then
passed to the IF/ID register.

Instruction Decode (ID) - Instruction is decoded into fields, determining the opcode, rs, rt, rd, immediate values etc.
Control signals are generated and immediate values are sign-extended. Register values, control signals and sign-extended
values are passed to the ID/EX register.

Execution (EX) - ALU produces result of relevant operation and is passed to EX/MEM register. Values are forwarded when required. 

Memory Access (MEM) - Data memory is accessed when required. Instruction is passed to MEM/WB register.

Write-Back (WB) - Register values are updated.

### Hazard Handling

#### Forwarding

#### EX/MEM → EX Forwarding

When an instruction in the EX stage consumes a register whose newest value is
being produced by the preceding instruction in EX/MEM, the result is forwarded
directly from EX/MEM to the appropriate ALU input rather than waiting for
write-back.

#### MEM/WB → EX Forwarding

When an instruction in EX consumes a register whose newest value is available
in MEM/WB, the final write-back value is forwarded to the appropriate ALU input.

#### STORE-Data Forwarding

`STORE` requires the value to be written to memory independently of the ALU
address calculation. A dedicated forwarding path therefore supplies newer
register values directly to the store-data path. An immediately preceding
`LOAD` cannot use EX/MEM forwarding because the loaded value is not yet
available; this case is handled by the load-use stall mechanism.

#### Load-use hazards

When an instruction following a `LOAD` depends on a register which is being loaded to, a one-cycle stall has to occur as the pipeline needs to wait for the `LOAD` to reach the MEM stage, the result from which can then be forwarded. This means the program counter value is held constant for one clock cycle, the instruction in the IF/ID register is held, and a bubble (essentially a NOP) is inserted into the ID/EX register. 

#### Control hazards

For BEQ/BNE, the branch is initially assumed to not be taken, but when the branch condition is met, the IF/ID and ID/EX registers are flushed to prevent the execution of the wrong instructions. A similar process occurs for JMP. For HALT, the pipeline registers are also flushed of all the instructions following HALT to prevent subsequent execution, and the program counter value is held constant.

## Simulation

### Requirements

- Verilator
- Make
- GCC/Clang
- Surfer (optional)

### Run an Individual Test

```bash
make run-cpu TEST=test_alu
```

### View Waveforms

```bash
surfer waves/cpu_pipeline_tb.vcd
```

## Regression Testing

Run:

```bash
make regression
```

What the regression suite tests:
- arithmetic
- memory
- forwarding
- load-use hazards
- STORE forwarding
- BEQ taken/not taken
- BNE taken/not taken
- jumps
- HALT

## Verification

The C reference model provides an implementation of the architectural ISA
independent of the pipelined RTL microarchitecture. The SystemVerilog
implementation is verified using directed tests and an automated regression
suite covering arithmetic, memory access, forwarding, load-use stalls,
store-data forwarding, control hazards, jumps and halting.

The separation between the architectural reference model and pipelined RTL
allows processor behaviour to be verified independently of the mechanisms used
to implement pipelining.

## FPGA Implementation

### Toolchain

- Yosys
- nextpnr
- OSS CAD Suite

### Synthesis

```bash
yosys -p "read_verilog -sv -Irtl rtl/*.sv fpga/fpga_top.sv; hierarchy -top fpga_top; synth_ecp5 -json fpga_top.json"
```
### Place and Route

The synthesized JSON netlist is placed and routed for the target ECP5 device
using `nextpnr-ecp5`:

```bash
nextpnr-ecp5 \
  --12k \
  --package CABGA381 \
  --json fpga_top.json \
  --lpf fpga/ulx3s.lpf \
  --textcfg fpga_top.config
```

### Target Device

Board: ULX3S
FPGA: Lattice ECP5

### Results

| Metric | Result |
|--------|--------|
| Post-P&R Fmax | 52.1 MHz |
| Corresponding minimum clock period | 19.2 ns |
| LUTs | 500 |
| Flip-flops | 181|
| BRAM | 7 |

The maximum clock frequency is taken from the post-place-and-route timing
analysis rather than from RTL synthesis alone, and therefore includes
device-specific placement and routing delays.

## Future Work

Possible extensions:
- UART
- interrupts
- additional instructions
- branch prediction
- caches
- more extensive verification

## Author
Callum McDuff
