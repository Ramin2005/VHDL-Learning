# VHDL Learning

A collection of **VHDL digital-design implementations** developed to practice combinational and sequential hardware design and to translate digital-logic concepts into synthesizable RTL.

The repository progresses from fundamental building blocks to larger datapath and storage components, including decoders, multiplexers, priority encoders, flip-flops, registers, counters, a 64-bit ALU, and a 64-bit combinational barrel shifter.

> **Scope:** This is an educational VHDL laboratory. The modules are standalone exercises and are not yet integrated into a complete processor or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── Decoder/
├── Priority Encoder/
│   ├── Greater Priority/
│   └── Smaller Priority/
├── MUX/
├── Full Adder/
├── Flip-Flops/
├── Register/
│   ├── Counters/
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

Implemented using:

- `S = A XOR B XOR Cin`
- `Cout = AB + ACin + BCin`

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

Standalone MUX implementations are provided from 2-to-1 through 64-to-1.

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

Two complementary priority-selection behaviors are implemented, each from 2-to-1 through 64-to-6.

#### Greater Priority

The input vector is scanned from the highest index toward the lowest. If multiple inputs are asserted, the **highest-index asserted input** wins.

#### Smaller Priority

The input vector is scanned from the lowest index toward the highest. If multiple inputs are asserted, the **lowest-index asserted input** wins.

Each encoder provides `D`, encoded output `A), and `Valid`.

| Variant | 2→1 | 4→2 | 8→3 | 16→4 | 32→5 | 64→6 |
|---|---|---|---|---|---|---|
| Greater Priority | Implemented | Implemented | Implemented | Implemented | Implemented | Implemented |
| Smaller Priority | Implemented | Implemented | Implemented | Implemented | Implemented | Implemented |

### Flip-Flops

**Directory:** `Flip-Flops/`

#### D Flip-Flop

A rising-edge-triggered D flip-flop with `Q` and complementary `NQ` outputs.

#### JK Flip-Flop

A rising-edge-triggered JK flip-flop implementing:

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

They provide rising-edge clocking, synchronous active-high reset, and parallel loading through `Load`.

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

The modules also expose serial-end outputs `QSL` and `QSR`.

### BCD Counters

**Directory:** `Register/Counters/`

- **BCD Up Counter:** `0 → 1 → ... → 9 → 0`
- **BCD Down Counter:** `9 → 8 → ... → 0 → 9`

Both use rising-edge clocking, synchronous active-high reset, and a 4-bit BCD output.

### 64-bit ALU

**Source:** `ALU/ALU.vhd`

A combinational 64-bit ALU controlled by a 5-bit opcode.

#### Logic Operations

`NOT`, `AND`, `OR`, `XOR`, `NAND`, `NOR`, `XNOR`

#### Comparison Operations

`A = B`, `A ≠ B`, `A < B`, `A > B`, `A ≤ B`, `A ≥ B`

Relational comparisons use **signed interpretation** of the 64-bit operands.

#### Arithmetic Operations

`ADD`, `SUB`, `INC`, `DEC`, `NEG`

The arithmetic datapath provides carry and overflow outputs.

#### Shift / Rotate Operations

`SHL`, `SHR`, `ASR`, `ROL`, `ROR`

The ALU shift/rotate operations are **single-bit operations**. Variable-distance shifting and rotation are handled by the separate barrel shifter.

Unassigned opcode values use the buffer/pass-through path.

### 64-bit Combinational Barrel Shifter

**Directory:** `64-Bit Combinational Barrel Shifter/`

#### Enable-Based Implementation

**Source:** `Enable Base/EnableBaseCBS.vhd`

Inputs include a 64-bit data input `A`, a 6-bit shift amount `S1), and a 3-bit operation selector `S2`.

Supported operations:

| Operation | Opcode |
|---|---|
| SHL | `000` |
| SHR | `001` |
| ASL | `010` |
| ASR | `011` |
| ROL | `100` |
| ROR | `101` |

The implementation uses `numeric_std` shift/rotate operations and enable-based result selection.

In the current implementation, **ASL produces the same result as SHL**.

#### MUX-Based Implementation

**Directory:** `Mux Base/`

- `Mux64to1.vhd` is implemented as a standalone 64-to-1 selection component.
- `MuxBaseCBS.vhd` is currently an empty placeholder.

Therefore, the complete MUX-based barrel shifter is **not yet implemented**.

## Design Concepts Practiced

- VHDL entity/architecture structure
- Combinational RTL
- Clocked sequential RTL
- `std_logic) and `std_logic_vector`
- `signed) and `unsigned`
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
| 64-bit ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| 64-to-1 MUX for Barrel Shifter | Implemented |
| Barrel Shifter — MUX Base | Not yet implemented |
| Up/Down Counter | Not yet implemented |

## Known Repository Notes

The current tree contains two unfinished areas:

1. `Register/Counters/UpDownCponter/UpDownCponter.vhd` — placeholder for a future up/down counter.
2. `64-Bit Combinational Barrel Shifter/Mux Base/MuxBaseCBS.vhd` — placeholder for the future MUX-based barrel shifter.

Two implemented files also require cleanup before being considered fully complete:

- `Register/Parallel Load Register/PLRegister8Bit.vhd` — entity/architecture naming is inconsistent with the 8-bit module filename.
- `Register/Universal Shift Register/USRegister8Bit.vhd` — the current port declaration contains a VHDL syntax error and needs a separator between declarations.

The remaining implemented modules should be validated with dedicated testbenches as the repository evolves.

## Purpose

This repository is an **educational VHDL laboratory** for building practical RTL and digital-design skills.

The progression is intentionally focused on:

`Logic → Decoders / MUXes → Priority Encoders → Flip-Flops → Registers / Counters → ALU / Barrel Shifter`

The long-term goal is to use these building blocks as a foundation for more advanced FPGA and digital-system design.
