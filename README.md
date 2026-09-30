# VHDL Learning

A collection of **VHDL digital-design implementations** developed to practice combinational and sequential RTL design and to translate fundamental digital-logic concepts into synthesizable hardware descriptions.

The repository currently progresses from basic building blocks to larger datapath and storage components, including decoders, multiplexers, priority encoders, flip-flops, registers, counters, a 64-bit ALU, and a 64-bit combinational barrel shifter.

> **Scope:** This is an educational VHDL laboratory. The modules are standalone design exercises and are not yet integrated into a complete processor or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── Decoder/
├── MUX/
├── Priority Encoder/
│   ├── Greater Priority/
│   └── Smaller Priority/
├── Full Adder/
├── Flip-Flops/
├── Register/
│   ├── Counter/
│   │   ├── BCD Counter/
│   │   └── UpDownCounter/
│   ├── Parallel Load Register/
│   └── Universal Shift Register/
├── ALU/
├── 64-Bit Combinational Barrel Shifter/
│   ├── Enable Base/
│   └── Mux Base/
└── README.md
```

## Implemented Modules

### Full Adder

**Source:** `Full Adder/FA.vhd`

A 1-bit full adder with two operands, carry input, sum output, and carry output.

```text
S    = A XOR B XOR Cin
Cout = AB + ACin + BCin
```

### Decoders

**Directory:** `Decoder/`

Enabled one-hot decoders are implemented from 1-to-2 through 6-to-64.

| Module | Inputs | Outputs |
|---|---:|---:|
| `Decoder1to2` | 1 | 2 |
| `Decoder2to4` | 2 | 4 |
| `Decoder3to8` | 3 | 8 |
| `Decoder4to16` | 4 | 16 |
| `Decoder5to32` | 5 | 32 |
| `Decoder6to64` | 6 | 64 |

The selected output is generated from the binary input and gated by enable `E`.

### Multiplexers

**Directory:** `MUX/`

Standalone multiplexers are implemented from 2-to-1 through 64-to-1.

| Module | Inputs | Select |
|---|---:|---:|
| `MUX2to1` | 2 | 1 bit |
| `MUX4to1` | 4 | 2 bits |
| `MUX8to1` | 8 | 3 bits |
| `MUX16to1` | 16 | 4 bits |
| `MUX32to1` | 32 | 5 bits |
| `MUX64to1` | 64 | 6 bits |

### Priority Encoders

**Directory:** `Priority Encoder/`

Two complementary priority-selection families are implemented, each from 2-to-1 through 64-to-6.

#### Greater Priority

The input vector is scanned from the highest index toward the lowest. When multiple inputs are asserted, the **highest-index asserted input** is selected.

#### Smaller Priority

The input vector is scanned from the lowest index toward the highest. When multiple inputs are asserted, the **lowest-index asserted input** is selected.

Both families provide the encoded output and a `Valid` indication.

| Variant | 2→1 | 4→2 | 8→3 | 16→4 | 32→5 | 64→6 |
|---|---|---|---|---|---|---|
| Greater Priority | Implemented | Implemented | Implemented | Implemented | Implemented | Implemented |
| Smaller Priority | Implemented | Implemented | Implemented | Implemented | Implemented | Implemented |

### Flip-Flops

**Directory:** `Flip-Flops/`

#### D Flip-Flop

A rising-edge-triggered D flip-flop with `Q` and complementary `NQ` outputs.

#### JK Flip-Flop

A rising-edge-triggered JK flip-flop implementing the standard behavior:

| J | K | Operation |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

### Registers

**Directory:** `Register/`

#### Parallel Load Registers

Implemented widths:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

The registers use rising-edge clocking, synchronous active-high reset, and parallel loading through `Load`.

#### Universal Shift Registers

Implemented widths:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

The current control encoding is:

| `S` | Operation |
|---|---|
| `00` | Hold |
| `01` | Parallel Load |
| `10` | Shift toward LSB; insert `SI` at bit 0 |
| `11` | Shift toward MSB; insert `SI` at the MSB |

The modules also expose the serial-end outputs `QSL` and `QSR`.

### Counters

**Directory:** `Register/Counter/`

#### BCD Counters

- **BCD Up Counter:** `0 → 1 → ... → 9 → 0`
- **BCD Down Counter:** `9 → 8 → ... → 0 → 9`

Both use rising-edge clocking, synchronous active-high reset, and a 4-bit BCD output.

#### Up/Down Counter

**Source:** `Register/Counter/UpDownCounter/UpDownCounter.vhd`

A 4-bit synchronous up/down counter.

| `S` | Operation |
|---|---|
| `0` | Count up: `0 → 1 → ... → 15 → 0` |
| `1` | Count down: `15 → 14 → ... → 0 → 15` |

The counter uses a rising-edge clock and synchronous active-high reset.

### 64-bit ALU

**Source:** `ALU/ALU.vhd`

A combinational 64-bit ALU controlled by a 5-bit opcode.

#### Logic Operations

`NOT`, `AND`, `OR`, `XOR`, `NAND`, `NOR`, `XNOR`

#### Comparison Operations

`A = B`, `A ≠ B`, `A < B`, `A > B`, `A ≤ B`, `A ≥ B`

The relational comparisons use **signed interpretation** of the 64-bit operands.

Comparison results are represented as 64-bit values with bit 0 set when the comparison is true.

#### Arithmetic Operations

`ADD`, `SUB`, `INC`, `DEC`, `NEG`

The arithmetic datapath uses extended intermediate values to preserve the carry output and provides overflow detection.

#### Shift / Rotate Operations

`SHL`, `SHR`, `ASR`, `ROL`, `ROR`

The ALU performs **single-bit** shift and rotate operations. Variable-distance shifts and rotations are handled by the separate barrel shifter.

#### Buffer

Opcode `11111` selects the input `A` directly. Unassigned opcode values also use the buffer path.

### 64-bit Combinational Barrel Shifter

**Directory:** `64-Bit Combinational Barrel Shifter/`

The barrel-shifter section provides a variable-distance combinational shift/rotate implementation and a separate MUX-based development area.

#### Enable-Based Implementation

**Source:** `Enable Base/EnableBaseCBS.vhd`

Inputs:

- `A`: 64-bit data input
- `S1`: 6-bit shift amount
- `S2`: 3-bit operation selector

Current operation encoding:

| Operation | Opcode |
|---|---|
| SHL | `000` |
| SHR | `001` |
| ASR | `010` |
| ROL | `011` |
| ROR | `100` |

Other operation-selector values use the buffer path.

The implementation uses `numeric_std` shift/rotate functions and an enable-based result-selection structure.

#### MUX-Based Implementation

**Directory:** `Mux Base/`

- `Mux64to1.vhd` is implemented as a standalone 64-to-1 multiplexer.
- `MuxBaseCBS.vhd` is currently an empty placeholder.

Therefore, the complete MUX-based barrel shifter is **not yet implemented**.

## Design Concepts Practiced

- VHDL entity/architecture structure
- Combinational RTL
- Clocked sequential RTL
- `std_logic` and `std_logic_vector`
- `signed` and `unsigned`
- IEEE `numeric_std`
- Boolean and bitwise logic
- Arithmetic operations
- Signed comparisons
- Carry and overflow handling
- Multiplexing and decoding
- Priority encoding
- Enable-based selection
- Shift and rotate operations
- Flip-flops and registers
- Universal shift registers
- BCD counters
- Up/down counters
- Larger combinational datapaths

## Libraries

The designs primarily use:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

## Current Status

| Component | Status |
|---|---|
| 1-to-2 through 6-to-64 Decoders | Implemented |
| 2-to-1 through 64-to-1 MUXes | Implemented |
| Greater Priority Encoders, 2-to-1 through 64-to-6 | Implemented |
| Smaller Priority Encoders, 2-to-1 through 64-to-6 | Implemented |
| 1-bit Full Adder | Implemented |
| D Flip-Flop | Implemented |
| JK Flip-Flop | Implemented |
| Parallel Load Registers, 4/8/16/32/64-bit | Implemented |
| Universal Shift Registers, 4/8/16/32/64-bit | Implemented |
| BCD Up Counter | Implemented |
| BCD Down Counter | Implemented |
| 4-bit Up/Down Counter | Implemented |
| 64-bit ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| 64-to-1 MUX for Barrel Shifter | Implemented |
| Barrel Shifter — MUX Base | Not yet implemented |

## Implementation Notes

- The repository uses a consistent English-comment style across the current VHDL module families.
- Register families are implemented at multiple widths while preserving the same basic control behavior.
- The 64-bit ALU and barrel shifter use `numeric_std` for typed arithmetic, signed/unsigned interpretation, and variable shift/rotate operations.
- The MUX-based barrel shifter remains the main unfinished hardware block in the current tree.
- The repository is currently focused on standalone RTL building blocks rather than integration into a larger CPU or FPGA system.

## Development Direction

The current progression is:

```text
Basic Logic
    ↓
Decoders / MUXes
    ↓
Priority Encoders
    ↓
Flip-Flops
    ↓
Registers / Counters
    ↓
64-bit ALU
    ↓
64-bit Barrel Shifter
    ↓
Future RTL Integration
```

The long-term goal is to use these building blocks as a foundation for more advanced FPGA, processor-datapath, and digital-system design.

## Purpose

This repository is an **educational VHDL laboratory** for developing practical RTL and digital-design skills through progressively larger hardware components.
