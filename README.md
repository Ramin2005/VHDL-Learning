# VHDL Learning

A collection of **VHDL RTL and digital-design implementations** for practicing combinational logic, sequential logic, datapath components, registers, counters, and reusable generic hardware blocks.

The repository is progressing from fundamental digital building blocks toward reusable, parameterized datapath components suitable as a foundation for future processor and FPGA-oriented work.

> **Scope:** This is an educational VHDL laboratory. The repository currently contains standalone RTL components and reusable generic blocks; it is not yet a complete processor or FPGA system.

## Repository Structure

```text
VHDL-Learning/
├── 64-Bit Combinational Barrel Shifter/
│   └── EnableBaseCBS.vhd
├── ALU/
│   ├── ALU.vhd
│   └── GenericALU.vhd
├── Bus/
│   └── GenericBus.vhd
├── Costume Types/
│   └── DataArray.vhd
├── Decoder/
├── Flip-Flop/
├── Full Adder/
├── MUX/
├── Priority Encoder/
│   ├── Greater Priority/
│   └── Smaller Priority/
└── Register/
    ├── Counter/
    │   ├── BCD Counter/
    │   └── UpDownCounter/
    ├── PC Register/
    ├── Parallel Load Register/
    ├── Shift Register/
    │   ├── Left Shift Register/
    │   └── Right Shift Register/
    └── Universal Shift Register/
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

- **Greater Priority:** selects the highest-index asserted input.
- **Smaller Priority:** selects the lowest-index asserted input.

Both families provide the encoded result and a `Valid` indication.

### Flip-Flops

**Directory:** `Flip-Flop/`

Implemented:

- D Flip-Flop
- JK Flip-Flop
- T Flip-Flop

The T flip-flop uses the standard behavior:

| T | Operation |
|---|---|
| 0 | Hold |
| 1 | Toggle |

### Registers

**Directory:** `Register/`

#### Parallel Load Registers

Fixed-width implementations:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

A generic `GenericPLRegister` is also implemented.

#### Shift Registers

Standalone implementations:

- 4-bit Left Shift Register
- 4-bit Right Shift Register

#### Universal Shift Registers

Fixed-width implementations:

- 4-bit
- 8-bit
- 16-bit
- 32-bit
- 64-bit

A generic `GenericUSRegister` is also implemented.

The universal shift-register family supports:

| `S` | Operation |
|---|---|
| `00` | Hold |
| `01` | Parallel Load |
| `10` | Shift toward LSB |
| `11` | Shift toward MSB |

### Counters

**Directory:** `Register/Counter/`

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

**Directory:** `Register/PC Register/`

Implemented:

- 32-bit PC Register
- 64-bit PC Register
- Generic PC Register

The generic PC register exposes configurable:

- `Width`
- `InstructionWidth`

and supports reset, load, and increment control.

> **Current implementation note:** the generic PC register is present and implemented, but its generic parameter validation should be reviewed before treating it as a fully reusable component for arbitrary parameter combinations.

### 64-bit ALU

**Directory:** `ALU/`

#### Fixed ALU

**Source:** `ALU/ALU.vhd`

A combinational 64-bit ALU supporting:

- Logic: `NOT`, `AND`, `OR`, `XOR`, `NAND`, `NOR`, `XNOR`
- Comparison: `=`, `≠`, `<`, `>`, `≤`, `≥`
- Arithmetic: `ADD`, `SUB`, `INC`, `DEC`, `NEG`
- Shift/rotate: `SHL`, `SHR`, `ASR`, `ROL`, `ROR`
- Buffer

Arithmetic operations provide carry and overflow outputs.

#### Generic ALU

**Source:** `ALU/GenericALU.vhd`

A width-parameterized ALU with:

```vhdl
GENERIC (
    Width : POSITIVE := 64
);
```

The generic implementation uses the configured width for its operands, results, arithmetic intermediates, carry/overflow logic, comparisons, and shift/rotate operations.

It retains the same 5-bit operation encoding as the fixed ALU.

### 64-bit Combinational Barrel Shifter

**Directory:** `64-Bit Combinational Barrel Shifter/`

**Source:** `EnableBaseCBS.vhd`

The current barrel-shifter implementation is an enable-based combinational design supporting variable-distance:

- SHL
- SHR
- ASR
- ROL
- ROR

The data path is 64-bit and the shift amount is 6 bits.

Invalid operation selectors use the buffer path.

> The previous MUX-based barrel-shifter development files are no longer present in the current repository tree. The current barrel-shifter implementation is the Enable-Based version.

## Bus and Custom Types

### DataArray Package

**Source:** `Costume Types/DataArray.vhd`

Defines an unconstrained VHDL array type for variable-width data words:

```vhdl
TYPE DataArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
```

### Generic Bus

**Source:** `Bus/GenericBus.vhd`

A parameterized bus/multiplexer structure with:

- `DataWidth`
- `AddressWidth`
- `NumberOfInputs`

The bus:

1. selects an input from `Inputs) using the address signal `S`;
2. gates the selected data with the `Enable) signal;
3. outputs the result through `O`.

The implementation uses the local `DataArray` package.

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
| Generic Universal Shift Register | Implemented |
| BCD Up Counter | Implemented |
| BCD Down Counter | Implemented |
| Up/Down Counter, 4/8/16-bit | Implemented |
| Generic Up/Down Counter | Implemented |
| PC Register, 32-bit | Implemented |
| PC Register, 64-bit | Implemented |
| Generic PC Register | Implemented |
| 64-bit ALU | Implemented |
| Generic ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| DataArray Package | Implemented |
| Generic Bus | Implemented |
| MUX-Based Barrel Shifter | Not present in current tree |

## Generic RTL Direction

Generic/parameterized RTL is now a central development direction of the repository.

Current generic components include:

```text
GenericPLRegister
GenericUSRegister
GenericUpDownCounter
GenericPCRegister
GenericALU
GenericBus
```

The goal is to reduce duplicated fixed-width implementations while preserving predictable hardware behavior through VHDL generics.

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
- Generic and parameterized RTL
- Unconstrained VHDL array types
- Datapath-oriented hardware organization

## Libraries

The designs primarily use:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

The Generic Bus additionally uses:

```vhdl
USE work.DataArray.ALL;
```

## Development Progression

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
Program Counter
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

- The repository primarily uses IEEE `std_logic_1164` and `numeric_std`.
- Fixed-width module families are being complemented by reusable generic implementations.
- Generic components currently cover registers, counters, program counters, the ALU, and the bus.
- The repository is increasingly focused on reusable datapath-oriented RTL rather than only isolated fixed-width exercises.
- The current tree should be treated as the source of truth for module availability; removed or superseded files are not described as active implementations.
- The repository remains a collection of standalone RTL components and is not yet integrated into a complete processor or FPGA system.

## Purpose

This repository is an **educational VHDL laboratory** for developing practical RTL, digital-design, and processor-datapath skills through progressively more reusable hardware components.
