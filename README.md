# VHDL Learning

A collection of **VHDL RTL and digital-design implementations** for practicing combinational logic, sequential logic, datapath components, registers, counters, and reusable generic hardware blocks.

The repository is being developed progressively from basic digital building blocks toward more reusable datapath and processor-oriented components.

> **Scope:** This is an educational VHDL laboratory. The repository currently contains standalone RTL components and early-stage reusable/generic building blocks; it is not yet a complete processor or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── 64-Bit Combinational Barrel Shifter/
│   ├── Enable Base/
│   └── Mux Base/
├── ALU/
├── Bus/
├── Costume Types/
├── Decoder/
├── Flip-Flop/
├── Full Adder/
├── MUX/
├── Priority Encoder/
│   ├── Greater Priority/
│   └── Smaller Priority/
├── Register/
│   ├── Counter/
│   │   ├── BCD Counter/
│   │   └── UpDownCounter/
│   ├── Flag Register/
│   ├── PC Register/
│   ├── Parallel Load Register/
│   ├── Shift Register/
│   │   ├── Left Shift Register/
│   │   └── Right Shift Register/
│   └── Universal Shift Register/
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

Two priority-encoder families are implemented from 2-to-1 through 64-to-6.

#### Greater Priority

Selects the **highest-index asserted input** when multiple inputs are active.

#### Smaller Priority

Selects the **lowest-index asserted input** when multiple inputs are active.

Both families provide the encoded result and a `Valid` indication.

### Flip-Flops

**Directory:** `Flip-Flop/`

Implemented:

- **D Flip-Flop**
- **JK Flip-Flop**
- **T Flip-Flop**

The flip-flops use rising-edge-triggered storage.

The T flip-flop implements the standard behavior:

| T | Operation |
|---|---|
| 0 | Hold |
| 1 | Toggle |

### Registers

**Directory:** `Register/`

#### Parallel Load Registers

Implemented widths:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

A generic parallel-load register implementation is also present:

`Register/Parallel Load Register/GenericPLRegister.vhd`

#### Universal Shift Registers

Implemented widths:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

The current control structure supports hold, parallel load, and bidirectional shifting.

#### Simple Shift Registers

The repository also contains standalone 4-bit:

- Left Shift Register
- Right Shift Register

### Counters

**Directory:** `Register/Counter/`

#### BCD Counters

- **BCD Up Counter:** `0 → 1 → ... → 9 → 0`
- **BCD Down Counter:** `9 → 8 → ... → 0 → 9`

#### Up/Down Counters

Fixed-width implementations are currently available for:

- 4-bit
- 8-bit
- 16-bit

A generic implementation is also present:

`Register/Counter/UpDownCounter/GenericUpDownCounter.vhd`

The generic version uses a configurable `Width` parameter and selects the counting direction with `S`.

### Program Counter Registers

**Directory:** `Register/PC Register/`

The repository contains:

- 32-bit PC register
- 64-bit PC register
- an additional generic-parameter-based PC-register development file

The implemented fixed-width PC registers support:

- synchronous reset
- loading a new PC value
- incrementing by the instruction width

The 32-bit and 64-bit fixed implementations increment by 4.

> The generic PC-register file is currently an **in-progress implementation** and should not be considered part of the stable module set yet.

### 64-bit ALU

**Directory:** `ALU/`

#### Fixed-width ALU

**Source:** `ALU/ALU.vhd`

The original ALU is a combinational 64-bit ALU with a 5-bit operation selector.

Supported operation groups include:

- Logic: `NOT`, `AND`, `OR`, `XOR`, `NAND`, `NOR`, `XNOR`
- Comparison: equality, inequality, less-than, greater-than, less/equal, greater/equal
- Arithmetic: `ADD`, `SUB`, `INC`, `DEC`, `NEG`
- Shift/rotate: `SHL`, `SHR`, `ASR`, `ROL`, `ROR`
- Buffer

The arithmetic section provides carry and overflow outputs.

#### Generic ALU

**Source:** `ALU/ALUGeneric.vhd`

A generic ALU interface has been added with:

```vhdl
GENERIC (
    Width : POSITIVE := 64
);
```

This is the beginning of converting the fixed-width datapath into reusable parameterized RTL.

> **Current development note:** although the interface is parameterized, parts of the current implementation still contain fixed 64-bit internal arithmetic assumptions. It should therefore be treated as a generic-development stage rather than a fully width-independent implementation.

### 64-bit Combinational Barrel Shifter

**Directory:** `64-Bit Combinational Barrel Shifter/`

#### Enable-Based Implementation

**Source:** `Enable Base/EnableBaseCBS.vhd`

The current implementation supports variable-distance:

- SHL
- SHR
- ASR
- ROL
- ROR

with a 6-bit shift amount for the 64-bit datapath.

#### MUX-Based Development

**Directory:** `Mux Base/`

`Mux64to1.vhd` is implemented as a standalone 64-to-1 multiplexer.

`MuxBaseCBS.vhd` is currently empty, so the complete MUX-based barrel shifter is **not yet implemented**.

## Bus and Custom Types

### DataArray Package

**Source:** `Costume Types/DataArray.vhd`

Defines a reusable unconstrained array type:

```vhdl
TYPE DataArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
```

This package is intended to support arrays of variable-width data words in reusable components.

### Generic Bus

**Source:** `Bus/GenericBus.vhd`

A parameterized bus interface has been introduced with configurable:

- `DataWidth`
- `AddressWidth`
- `NumberOfInputs`

It uses the `DataArray` package and is intended to select one data input using an address/select signal.

> The current `GenericBus.vhd` contains the entity/interface but does not yet contain a completed architecture. It is therefore an **in-progress module**.

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
- Flip-flops
- Parallel-load registers
- Shift registers
- Universal shift registers
- BCD counters
- Up/down counters
- Program-counter structures
- Generic/parameterized RTL
- Unconstrained VHDL array types
- Datapath-oriented hardware organization

## Libraries

The designs primarily use:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

Generic bus components additionally use the local `DataArray` package:

```vhdl
USE work.DataArray.ALL;
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
| T Flip-Flop | Implemented |
| Parallel Load Registers, 4/8/16/32/64-bit | Implemented |
| Generic Parallel Load Register | Implemented |
| Left Shift Register, 4-bit | Implemented |
| Right Shift Register, 4-bit | Implemented |
| Universal Shift Registers, 4/8/16/32/64-bit | Implemented |
| BCD Up Counter | Implemented |
| BCD Down Counter | Implemented |
| Up/Down Counter, 4/8/16-bit | Implemented |
| Generic Up/Down Counter | Implemented |
| PC Register, 32-bit | Implemented |
| PC Register, 64-bit | Implemented |
| Generic PC Register | In progress |
| 64-bit ALU | Implemented |
| Generic ALU | In progress |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| 64-to-1 MUX for Barrel Shifter | Implemented |
| Barrel Shifter — MUX Base | Not yet implemented |
| DataArray Package | Implemented |
| Generic Bus | In progress |
| Flag Register | Not yet implemented |

## Generic RTL Direction

One of the current development directions is replacing repeated fixed-width implementations with reusable parameterized components.

Current generic components include:

```text
GenericPLRegister
GenericUpDownCounter
ALUGeneric
GenericBus
Generic PC Register (in progress)
```

The goal is to preserve the same hardware behavior while allowing widths and other structural parameters to be selected through VHDL generics.

## Development Progression

The repository is currently evolving along this path:

```text
Basic Logic
    ↓
Decoders / MUXes
    ↓
Priority Encoders / Full Adder
    ↓
Flip-Flops
    ↓
Registers / Shift Registers / Counters
    ↓
Program Counter Structures
    ↓
64-bit ALU
    ↓
Generic / Parameterized RTL
    ↓
Bus and Datapath Components
    ↓
Barrel Shifter
    ↓
Future CPU / FPGA Integration
```

## Implementation Notes

- The repository is primarily written using IEEE `std_logic_1164` and `numeric_std`.
- Fixed-width module families are being complemented by generic versions where appropriate.
- The recent development direction focuses on **reusability and parameterization**, rather than only adding more fixed-width copies.
- The current generic modules are at different maturity levels; the status table distinguishes completed components from development-stage components.
- Empty or incomplete modules are intentionally identified as such rather than being presented as completed hardware.
- The repository remains focused on standalone RTL building blocks and has not yet been integrated into a complete processor or FPGA system.

## Purpose

This repository is an **educational VHDL laboratory** for developing practical RTL, digital-design, and processor-datapath skills through progressively more reusable hardware components.
