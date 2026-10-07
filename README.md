# VHDL Learning

A collection of **VHDL RTL and digital-design implementations** for practicing combinational logic, sequential logic, arithmetic datapath components, registers, counters, and reusable generic hardware blocks.

The repository is progressing from fundamental digital building blocks toward reusable, parameterized datapath components suitable as a foundation for future processor and FPGA-oriented work.

> **Scope:** This is an educational VHDL laboratory. The repository currently contains standalone RTL components and reusable generic blocks; it is not yet a complete processor, CPU, or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── Combinational Circuits/
│   ├── 64-Bit Combinational Barrel Shifter/
│   ├── ALU/
│   ├── Adder/
│   ├── Bus/
│   ├── Decoder/
│   ├── Divider/
│   ├── FPU/
│   ├── Full Adder/
│   ├── MUX/
│   ├── Multiplier/
│   └── Priority Encoder/
│       ├── Greater Priority/
│       └── Smaller Priority/
├── Costume Types/
├── Sequential Circuits/
│   ├── File Register/
│   ├── Flip-Flop/
│   └── Register/
│       ├── Counter/
│       │   ├── BCD Counter/
│       │   └── UpDownCounter/
│       ├── PC Register/
│       ├── Parallel Load Register/
│       ├── Shift Register/
│       │   ├── Left Shift Register/
│       │   └── Right Shift Register/
│       └── Universal Shift Register/
└── README.md
```

## Combinational Circuits

### Full Adder

**Source:** `Combinational Circuits/Full Adder/FA.vhd`

A 1-bit full adder with two operands, carry input, sum output, and carry output.

```text
S    = A XOR B XOR Cin
Cout = AB + ACin + BCin
```

### Generic Adder

**Source:** `Combinational Circuits/Adder/GenericAdder.vhd`

A parameterized binary adder with:

- Configurable operand width
- Carry input
- Sum output
- Carry output
- Signed overflow detection

Default width:

```vhdl
Width : POSITIVE := 64
```

### Decoders

**Directory:** `Combinational Circuits/Decoder/`

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

**Directory:** `Combinational Circuits/MUX/`

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

**Directory:** `Combinational Circuits/Priority Encoder/`

Two priority-encoder families are implemented from 2-to-1 through 64-to-6.

- **Greater Priority:** selects the highest-index asserted input.
- **Smaller Priority:** selects the lowest-index asserted input.

Both families provide the encoded result and a `Valid` indication.

### 64-bit ALU

**Directory:** `Combinational Circuits/ALU/`

#### Fixed ALU

**Source:** `ALU.vhd`

A combinational 64-bit ALU supporting:

- Logic: `NOT`, `AND`, `OR`, `XOR`, `NAND`, `NOR`, `XNOR`
- Comparison: equality, inequality, less-than, greater-than, less/equal, greater/equal
- Arithmetic: `ADD`, `SUB`, `INC`, `DEC`, `NEG`
- Shift/rotate: `SHL`, `SHR`, `ASR`, `ROL`, `ROR`
- Buffer

Arithmetic operations provide carry and overflow outputs.

#### Generic ALU

**Source:** `GenericALU.vhd`

A width-parameterized version of the ALU.

```vhdl
GENERIC (
    Width : POSITIVE := 64
);
```

The generic implementation uses the configured width for operands, results, arithmetic intermediates, comparisons, carry/overflow logic, and shift/rotate operations.

### 64-bit Combinational Barrel Shifter

**Directory:** `Combinational Circuits/64-Bit Combinational Barrel Shifter/`

**Source:** `EnableBaseCBS.vhd`

The current barrel shifter is an enable-based combinational design supporting variable-distance:

- SHL
- SHR
- ASR
- ROL
- ROR

The datapath is 64-bit and the shift amount is 6 bits.

### Generic Bus

**Source:** `Combinational Circuits/Bus/GenericBus.vhd`

A parameterized bus/multiplexer structure using the reusable `DataArray` type.

Configurable parameters include:

- `DataWidth`
- `AddressWidth`
- `NumberOfInputs`

The implementation selects an input using the address signal and gates the selected data with `Enable`.

### Generic Multipliers

**Directory:** `Combinational Circuits/Multiplier/`

Implemented:

- `GenericSignedMultiplier`
- `GenericUnsignedMultiplier`

Both use configurable operand width and produce a full-width product of:

`2 × WIDTH` bits.

Default width:

`WIDTH = 64`

### Generic Dividers

**Directory:** `Combinational Circuits/Divider/`

Implemented:

- `GenericSignedDivider`
- `GenericUnsignedDivider`

Both provide:

- Quotient
- Remainder
- Configurable operand width

Default width:

`WIDTH = 64`

### FPU

**Directory:** `Combinational Circuits/FPU/`

The repository currently contains:

- `FPU.vhd`
- `GenericFPU.vhd`

Both files are currently empty placeholders.

**Status: Not yet implemented.**

## Sequential Circuits

### Flip-Flops

**Directory:** `Sequential Circuits/Flip-Flop/`

Implemented:

- D Flip-Flop
- JK Flip-Flop
- T Flip-Flop

The T flip-flop follows the standard behavior:

| T | Operation |
|---|---|
| 0 | Hold |
| 1 | Toggle |

### Register File

**Directory:** `Sequential Circuits/File Register/`

#### 32 × 64-bit Register File

**Source:** `FileRegister32R64B.vhd`

Provides:

- 32 registers
- 64-bit register width
- Two asynchronous read ports
- One synchronous write port
- 5-bit addresses

#### 32 × 64-bit Register File with Clear

**Source:** `FileRegister32R64BWithClear.vhd`

Extends the register file with a synchronous clear operation that clears all 32 registers.

### Parallel Load Registers

**Directory:** `Sequential Circuits/Register/Parallel Load Register/`

Fixed-width implementations:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

A reusable `GenericPLRegister` is also implemented.

### Shift Registers

**Directory:** `Sequential Circuits/Register/Shift Register/`

Standalone implementations:

- 4-bit Left Shift Register
- 4-bit Right Shift Register

### Universal Shift Registers

**Directory:** `Sequential Circuits/Register/Universal Shift Register/`

Fixed-width implementations:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

A reusable `GenericUSRegister` is also implemented.

The universal shift-register family supports:

| `S` | Operation |
|---|---|
| `00` | Hold |
| `01` | Parallel Load |
| `10` | Shift toward LSB |
| `11` | Shift toward MSB |

### Counters

**Directory:** `Sequential Circuits/Register/Counter/`

#### BCD Counters

- BCD Up Counter: `0 → 1 → ... → 9 → 0`
- BCD Down Counter: `9 → 8 → ... → 0 → 9`

#### Up/Down Counters

Fixed-width implementations:

- 4-bit
- 8-bit
- 16-bit

A generic `GenericUpDownCounter` is also implemented with configurable width and selectable counting direction.

### Program Counter

**Directory:** `Sequential Circuits/Register/PC Register/`

Implemented:

- 32-bit PC Register
- 64-bit PC Register
- Generic PC Register

The generic PC register exposes configurable width and instruction width and supports reset, load, and increment control.

## Custom Types

### DataArray

**Source:** `Costume Types/DataArray.vhd`

Defines an unconstrained VHDL array type for variable-width data words:

```vhdl
TYPE DataArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
```

This type is used by reusable datapath components such as the Generic Bus.

## Current Status

| Component | Status |
|---|---|
| 1-to-2 through 6-to-64 Decoders | Implemented |
| 2-to-1 through 64-to-1 MUXes | Implemented |
| Greater Priority Encoders, 2-to-1 through 64-to-6 | Implemented |
| Smaller Priority Encoders, 2-to-1 through 64-to-6 | Implemented |
| 1-bit Full Adder | Implemented |
| Generic Adder | Implemented |
| 64-bit ALU | Implemented |
| Generic ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| Generic Bus | Implemented |
| Generic Signed Multiplier | Implemented |
| Generic Unsigned Multiplier | Implemented |
| Generic Signed Divider | Implemented |
| Generic Unsigned Divider | Implemented |
| FPU | Not yet implemented |
| Generic FPU | Not yet implemented |
| D Flip-Flop | Implemented |
| JK Flip-Flop | Implemented |
| T Flip-Flop | Implemented |
| 32 × 64-bit Register File | Implemented |
| 32 × 64-bit Register File with Clear | Implemented |
| Parallel Load Registers, 4/8/16/32/64-bit | Implemented |
| Generic Parallel Load Register | Implemented |
| Left Shift Register, 4-bit | Implemented |
| Right Shift Register, 4-bit | Implemented |
| Universal Shift Registers, 4/8/16/32/64-bit | Implemented |
| Generic Universal Shift Register | Implemented |
| BCD Up Counter | Implemented |
| BCD Down Counter | Implemented |
| Up/Down Counter, 4/8/16-bit | Implemented |
| Generic Up/Down Counter | Implemented |
| PC Register, 32-bit | Implemented |
| PC Register, 64-bit | Implemented |
| Generic PC Register | Implemented |
| DataArray Package | Implemented |

## Generic RTL Direction

Generic/parameterized RTL is now a central development direction of the repository.

Current generic components include:

```text
GenericAdder
GenericALU
GenericBus
GenericSignedMultiplier
GenericUnsignedMultiplier
GenericSignedDivider
GenericUnsignedDivider
GenericPLRegister
GenericUSRegister
GenericUpDownCounter
GenericPCRegister
```

These components are intended to reduce duplicated fixed-width implementations and make the datapath easier to reuse at different widths.

## Design Concepts Practiced

- VHDL entity/architecture structure
- Combinational RTL
- Clocked sequential RTL
- `std_logic` and `std_logic_vector`
- `signed` and `unsigned`
- IEEE `numeric_std`
- Boolean and bitwise logic
- Arithmetic operations
- Signed and unsigned comparisons
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
- Register-file organization
- Program-counter structures
- Generic and parameterized RTL
- Signed and unsigned multiplication
- Signed and unsigned division
- Quotient and remainder generation
- Unconstrained VHDL array types
- Datapath-oriented hardware organization

## Libraries

The designs primarily use:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

The Generic Bus additionally uses the local `DataArray` package.

## Development Progression

```text
Basic Logic
    ↓
Decoders / MUXes
    ↓
Priority Encoders / Adders
    ↓
Flip-Flops
    ↓
Registers / Shift Registers / Counters
    ↓
Register File / Program Counter
    ↓
64-bit ALU
    ↓
Generic Arithmetic
    ↓
Generic Bus / Datapath Components
    ↓
Barrel Shifter
    ↓
Multiplier / Divider
    ↓
Future FPU
    ↓
Future CPU / FPGA Integration
```

## Implementation Notes

- The repository primarily uses IEEE `std_logic_1164` and `numeric_std`.
- Fixed-width module families are being complemented by reusable generic implementations.
- Generic components now cover arithmetic, ALU, bus, registers, counters, and program-counter structures.
- The repository is increasingly focused on reusable datapath-oriented RTL rather than only isolated fixed-width exercises.
- The FPU files are currently placeholders and are intentionally marked as not implemented.
- The current repository tree is the source of truth for module availability; removed or superseded files are not described as active implementations.
- The repository remains a collection of standalone RTL components and is not yet integrated into a complete processor or FPGA system.

## Purpose

This repository is an **educational VHDL laboratory** for developing practical RTL, digital-design, arithmetic-datapath, and processor-design skills through progressively more reusable hardware components.
