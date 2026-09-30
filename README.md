# VHDL Learning

A collection of **VHDL digital-design implementations** developed to practice combinational and sequential hardware design and to translate digital-logic concepts into synthesizable VHDL descriptions.

The repository currently contains:

- Basic combinational building blocks
- Enabled binary decoders from 1-to-2 through 6-to-64
- Multiplexers from 2-to-1 through 64-to-1
- Priority encoders from 2-to-1 through 64-to-6
- Parallel-load registers from 4-bit through 64-bit
- Universal shift registers from 4-bit through 64-bit
- A 1-bit Full Adder
- D and JK Flip-Flops
- A 64-bit ALU
- A 64-bit combinational barrel shifter and rotating unit
- An experimental MUX-based barrel-shifter implementation

The projects are standalone digital-design exercises and are not currently integrated into a complete processor or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── Decoder/
│   ├── Decoder1to2.vhd
│   ├── Decoder2to4.vhd
│   ├── Decoder3to8.vhd
│   ├── Decoder4to16.vhd
│   ├── Decoder5to32.vhd
│   └── Decoder6to64.vhd
│
├── Priority Encoder/
│   ├── PriorityEncoder2to1.vhd
│   ├── PriorityEncoder4to2.vhd
│   ├── PriorityEncoder8to3.vhd
│   ├── PriorityEncoder16to4.vhd
│   ├── PriorityEncoder32to5.vhd
│   └── PriorityEncoder64to6.vhd
│
├── Register/
│   ├── Counters/
│   │   ├── BCDUpCounter.vhd
│   │   └── BCDDownCounter.vhd
│   │
│   ├── Parallel Load Register/
│   │   ├── PLRegister4Bit.vhd
│   │   ├── PLRegister8Bit.vhd
│   │   ├── PLRegister16Bit.vhd
│   │   ├── PLRegister32Bit.vhd
│   │   └── PLRegister64Bit.vhd
│   │
│   └── Universal Shift Register/
│       ├── USRegister4Bit.vhd
│       ├── USRegister8Bit.vhd
│       ├── USRegister16Bit.vhd
│       ├── USRegister32Bit.vhd
│       └── USRegister64Bit.vhd
│
├── Full Adder/
│   └── FA.vhd
│
├── MUX/
│   ├── MUX2to1.vhd
│   ├── MUX4to1.vhd
│   ├── MUX8to1.vhd
│   ├── MUX16to1.vhd
│   ├── MUX32to1.vhd
│   └── MUX64to1.vhd
│
├── Flip-Flops/
│   ├── DFlipFlop.vhd
│   └── JKFlipFlop.vhd
│
├── ALU/
│   └── ALU.vhd
│
├── 64-Bit Combinational Barrel Shifter/
│   ├── Enable Base/
│   │   └── EnableBaseCBS.vhd
│   └── Mux Base/
│       ├── Mux64to1.vhd
│       └── MuxBaseCBS.vhd
│
└── README.md
```

## Projects

### 1. Full Adder

**Source:** `Full Adder/FA.vhd`

A 1-bit full adder with:

- Two operands: `A`, `B`
- Carry input: `Cin`
- Sum output: `S`
- Carry output: `Cout`

The implementation directly uses the standard Boolean equations:

- `S = A XOR B XOR Cin`
- `Cout = AB + ACin + BCin`

### 2. Decoders

**Directory:** `Decoder/`

The repository contains enabled one-hot decoder implementations from 1-to-2 through 6-to-64:

| Module | Inputs | Outputs |
|---|---:|---:|
| `Decoder1to2` | 1 | 2 |
| `Decoder2to4` | 2 | 4 |
| `Decoder3to8` | 3 | 8 |
| `Decoder4to16` | 4 | 16 |
| `Decoder5to32` | 5 | 32 |
| `Decoder6to64` | 6 | 64 |

Each decoder has an enable input `E`. The selected output is generated from the binary input using `shift_left`, while the enable signal controls whether the decoded output is active.

### 3. Priority Encoders

**Directory:** `Priority Encoder/`

The repository contains priority encoder implementations for progressively wider input vectors:

| Module | Inputs | Encoded Output |
|---|---:|---:|
| `PriorityEncoder2to1` | 2 | 1 bit |
| `PriorityEncoder4to2` | 4 | 2 bits |
| `PriorityEncoder8to3` | 8 | 3 bits |
| `PriorityEncoder16to4` | 16 | 4 bits |
| `PriorityEncoder32to5` | 32 | 5 bits |
| `PriorityEncoder64to6` | 64 | 6 bits |

Each implementation scans the input vector from the highest index toward the lowest index and encodes the first asserted input, giving higher-index inputs priority. A `Valid` output indicates whether at least one input bit is asserted.

The current `PriorityEncoder64to6.vhd` is implemented with the expected `PriorityEncoder64to6` entity and architecture names.

### 4. Multiplexers

**Directory:** `MUX/`

The repository contains standalone MUX implementations with increasing input widths:

| Module | Inputs | Select |
|---|---:|---:|
| `MUX2to1` | 2 | 1 bit |
| `MUX4to1` | 4 | 2 bits |
| `MUX8to1` | 8 | 3 bits |
| `MUX16to1` | 16 | 4 bits |
| `MUX32to1` | 32 | 5 bits |
| `MUX64to1` | 64 | 6 bits |

The larger MUX implementations use an indexed `std_logic_vector` with `to_integer(unsigned(S))`, while the 2-to-1 and 4-to-1 versions explicitly describe the selection logic with Boolean expressions.

These modules provide basic selection structures that are also useful when constructing larger combinational datapaths.

### 5. Flip-Flops

**Directory:** `Flip-Flops/`

#### D Flip-Flop

**Source:** `Flip-Flops/DFlipFlop.vhd`

A rising-edge-triggered D flip-flop with:

- Clock: `CLK`
- Data input: `D`
- Output: `Q`
- Complement output: `NQ`

The state is updated on `rising_edge(CLK)`.

#### JK Flip-Flop

**Source:** `Flip-Flops/JKFlipFlop.vhd`

A rising-edge-triggered JK flip-flop implementing the four standard JK states:

| J | K | Next State |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

The implementation exposes both `Q` and `NQ`.

### 6. 64-bit ALU

**Source:** `ALU/ALU.vhd`

A combinational 64-bit Arithmetic Logic Unit controlled by a 5-bit opcode.

The current implementation contains **25 explicitly defined operations**, plus a buffer/pass-through operation. The opcode field is 5 bits wide, so 32 selector values are available; unassigned selector values use the buffer path.

#### Logic Operations

| Operation | Opcode |
|---|---|
| NOT | `00000` |
| AND | `00001` |
| OR | `00010` |
| XOR | `00011` |
| NAND | `00100` |
| NOR | `00101` |
| XNOR | `00110` |

#### Comparison Operations

| Operation | Opcode |
|---|---|
| A = B | `00111` |
| A ≠ B | `01000` |
| A < B | `01001` |
| A > B | `01010` |
| A ≤ B | `01011` |
| A ≥ B | `01100` |

The relational comparisons use **signed interpretation** of the two 64-bit operands.

For comparison operations, the result is represented as a 64-bit vector with bit 0 indicating the Boolean result.

#### Arithmetic Operations

| Operation | Opcode |
|---|---|
| ADD | `10000` |
| SUB | `10001` |
| INC | `10010` |
| DEC | `10011` |
| NEG | `10100` |

The ALU uses 65-bit intermediate unsigned signals for the arithmetic datapath and provides:

- `Cout`
- `Overflow`

#### Shift and Rotate Operations

| Operation | Opcode |
|---|---|
| SHL | `10101` |
| SHR | `10110` |
| ASR | `10111` |
| ROL | `11000` |
| ROR | `11001` |

Opcode `11111` performs a buffer/pass-through operation. Opcodes that are not explicitly assigned to an operation also select the buffer path.

### 7. 64-bit Combinational Barrel Shifter and Rotating Unit

**Directory:** `64-Bit Combinational Barrel Shifter/`

The repository contains an enable-based implementation and the beginning of an alternative MUX-oriented implementation.

#### Enable-Based Implementation

**Source:** `64-Bit Combinational Barrel Shifter/Enable Base/EnableBaseCBS.vhd`

The module accepts:

- 64-bit input: `A`
- 6-bit shift amount: `S1`
- 3-bit operation selector: `S2`
- 64-bit output: `Result`

Supported operations:

| Operation | Opcode |
|---|---|
| SHL | `000` |
| SHR | `001` |
| ASL | `010` |
| ASR | `011` |
| ROL | `100` |
| ROR | `101` |

The implementation uses `numeric_std` shift/rotate operations and an enable-based result-selection structure.

Invalid operation codes, and the zero-shift case in the current enable logic, select the buffer path.

**Implementation note:** the current `ASL` selection uses `ResultSHL`; therefore, it behaves identically to the logical left shift in this implementation.

#### MUX-Based Implementation

**Directory:** `64-Bit Combinational Barrel Shifter/Mux Base/`

The directory currently contains:

- `Mux64to1.vhd` — implemented 64-to-1 single-bit multiplexer using explicit enable decoding and Boolean selection.
- `MuxBaseCBS.vhd` — currently an empty placeholder for the future MUX-based barrel-shifter implementation.

The MUX-based barrel shifter itself is therefore **not yet implemented**. The standalone `Mux64to1` module is implemented.

### 8. Registers

**Directory:** `Register/`

The repository now includes two families of clocked registers, each implemented at 4, 8, 16, 32, and 64 bits.

#### Parallel Load Registers

**Directory:** `Register/Parallel Load Register/`

These registers provide:

- Rising-edge clocking
- Synchronous reset
- Parallel data loading controlled by `Load`
- Widths: 4, 8, 16, 32, and 64 bits

For example, `PLRegister64Bit` stores a 64-bit input vector and loads it on the rising clock edge when `Load = '1'`.

#### Universal Shift Registers

**Directory:** `Register/Universal Shift Register/`

These registers provide:

- Rising-edge clocking
- Synchronous reset
- Parallel loading
- Serial shifting in both directions
- Serial input `SI`
- Serial outputs `QSL` and `QSR`
- Widths: 4, 8, 16, 32, and 64 bits

The 2-bit control input `S` selects the register operation. In the current implementation:

| S | Operation |
|---|---|
| `00` | Hold |
| `01` | Parallel Load |
| `10` | Shift toward LSB / insert `SI` at bit 0 |
| `11` | Shift toward MSB / insert `SI` at the MSB |

### 9. BCD Counters

**Directory:** `Register/Counters/`

The repository includes two clocked BCD counters:

| Module | Function |
|---|---|
| `BCDUpCounter` | Counts upward from 0 to 9 and wraps back to 0 |
| `BCDDownCounter` | Counts downward from 9 to 0 and wraps back to 9 |

Both counters provide:

- Rising-edge clocking
- Synchronous active-high reset
- 4-bit BCD output `Q`
- Decimal wrap-around behavior

The counters use `numeric_std` for the increment/decrement operations and keep the stored value within the valid BCD digit range.

## Design Concepts Practiced

The current repository covers several fundamental digital-design concepts:

- VHDL entity/architecture structure
- Concurrent signal assignment
- Clocked processes and rising-edge triggering
- `std_logic` and `std_logic_vector`
- `signed` and `unsigned` representations
- `numeric_std`
- Boolean and bitwise logic
- Arithmetic operations
- Signed comparisons
- Carry and overflow detection
- Multiplexer structures
- Priority encoding
- Enable-based selection
- Shift and rotate operations
- Combinational datapaths
- Basic sequential storage elements
- Parallel-load registers
- Universal shift registers
- BCD up/down counters
- Modular hardware description

## Libraries

The designs primarily use IEEE standard VHDL libraries:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

`numeric_std` is used for operations involving signed/unsigned arithmetic, indexed selection, shifts, and rotations.

## Current Status

| Component | Status |
|---|---|
| 1-to-2 Decoder | Implemented |
| 2-to-4 Decoder | Implemented |
| 3-to-8 Decoder | Implemented |
| 4-to-16 Decoder | Implemented |
| 5-to-32 Decoder | Implemented |
| 6-to-64 Decoder | Implemented |
| 1-bit Full Adder | Implemented |
| Priority Encoder 2-to-1 | Implemented |
| Priority Encoder 4-to-2 | Implemented |
| Priority Encoder 8-to-3 | Implemented |
| Priority Encoder 16-to-4 | Implemented |
| Priority Encoder 32-to-5 | Implemented |
| Priority Encoder 64-to-6 | Implemented |
| 2-to-1 MUX | Implemented |
| 4-to-1 MUX | Implemented |
| 8-to-1 MUX | Implemented |
| 16-to-1 MUX | Implemented |
| 32-to-1 MUX | Implemented |
| 64-to-1 MUX | Implemented |
| D Flip-Flop | Implemented |
| JK Flip-Flop | Implemented |
| 64-bit ALU | Implemented |
| 4/8/16/32/64-bit Parallel Load Registers | Implemented |
| 4/8/16/32/64-bit Universal Shift Registers | Implemented |
| BCD Up Counter | Implemented |
| BCD Down Counter | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| 64-to-1 MUX for Barrel Shifter | Implemented |
| Barrel Shifter — MUX Base | Not yet implemented |


## Purpose

This repository serves as an **educational VHDL laboratory** for developing practical digital-design skills.

The current focus is on progressing from fundamental combinational and sequential components toward larger hardware blocks such as ALUs, barrel shifters, registers, and counters, while practicing how digital-logic structures are represented in synthesizable VHDL.

## License

This repository is intended for educational and experimental use.
