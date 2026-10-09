# VHDL Learning

A collection of **VHDL RTL and digital-design implementations** covering combinational logic, arithmetic datapaths, sequential circuits, register files, counters, and reusable generic hardware blocks.

The project is evolving from fundamental digital building blocks toward parameterized datapath components that can serve as a foundation for future processor and FPGA work.

> **Scope:** This is an educational RTL repository, not yet a complete CPU or FPGA system. The status below describes the files currently present in the repository; it does not imply that every module has been simulated, synthesized, or formally verified.

## Repository Structure

```text
VHDL-Learning/
├── Combinational Circuits/
│   ├── 64-Bit Combinational Barrel Shifter/
│   ├── ALU/
│   ├── Arithmetics/
│   │   ├── AdderSubtractor/
│   │   ├── Divider/
│   │   ├── FPU/
│   │   ├── Full Adder/
│   │   └── Multiplier/
│   ├── Bus/
│   ├── Decoder/
│   ├── MUX/
│   └── Priority Encoder/
│       ├── Greater Priority/
│       └── Smaller Priority/
├── Costume Types/
└── Sequential Circuits/
    ├── File Register/
    ├── Flip-Flop/
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

## Combinational Circuits

### Full Adder

**Source:** `Combinational Circuits/Arithmetics/Full Adder/FA.vhd`

A 1-bit full adder with two data inputs, a carry input, a sum output, and a carry output.

```text
Sum  = A XOR B XOR Cin
Cout = AB + ACin + BCin
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

Standalone multiplexers are implemented from 2-to-1 through 64-to-1, with the select width increasing from 1 to 6 bits.

### Priority Encoders

**Directory:** `Combinational Circuits/Priority Encoder/`

Two encoder families are implemented from 2-to-1 through 64-to-6:

- **Greater Priority:** selects the highest-index asserted input.
- **Smaller Priority:** selects the lowest-index asserted input.

Both families provide an encoded result and a `Valid` indication.

### ALU

**Directory:** `Combinational Circuits/ALU/`

The repository contains a fixed 64-bit ALU and a width-parameterized `GenericALU`.

The ALU source describes logic, comparison, arithmetic, shift/rotate, and buffer operations. The generic version exposes a `Width` generic (default 64) and result, carry, overflow, and divide-by-zero output ports.

> Operation encodings and implemented behavior should be verified against the current VHDL source before integrating the ALU into a processor. The source's operation comments and selection logic may not describe every operation consistently.

### Barrel Shifter

**Source:** `Combinational Circuits/64-Bit Combinational Barrel Shifter/EnableBaseCBS.vhd`

A 64-bit enable-based combinational barrel shifter supporting:

- SHL — logical left shift
- SHR — logical right shift
- ASR — arithmetic right shift
- ROL — rotate left
- ROR — rotate right

The shift amount is 6 bits.

### Generic Bus

**Source:** `Combinational Circuits/Bus/GenericBus.vhd`

A parameterized input-selection bus using the local `DataArray` type. Its generics include `DataWidth`, `AddressWidth`, and `NumberOfInputs`; the selected input is gated by `Enable`.

## Generic Arithmetic

The arithmetic modules are grouped under `Combinational Circuits/Arithmetics/`.

### Generic Adder/Subtractors

**Directory:** `AdderSubtractor/`

- `GenericSignedAdderSubtractor.vhd`
- `GenericUnsignedAdderSubtractor.vhd`

Both expose a configurable `Width` (default 64), operands `A` and `B), a mode selector `S`, and a `Result` output. The signed version also declares overflow output; the unsigned version provides carry output.

**Development note:** these files are present in the current tree, but their source should be reviewed and compiled before relying on them. In particular, the signed implementation currently contains inconsistent signal identifiers, so it should not be treated as verified RTL.

### Generic Multipliers

**Directory:** `Multiplier/`

- `GenericSignedMultiplier.vhd`
- `GenericUnsignedMultiplier.vhd`

Both accept configurable-width operands (default 64 bits) and produce a full-width product of `2 × WIDTH` bits.

### Generic Dividers

**Directory:** `Divider/`

- `GenericSignedDivider.vhd`
- `GenericUnsignedDivider.vhd`

Both provide quotient and remainder outputs for configurable-width operands (default 64 bits).

**Important:** the current divider entities do not expose a divide-by-zero status output. Division by zero and signed overflow cases should be handled or explicitly constrained by the surrounding design and verified in simulation.

### Floating-Point Unit (FPU)

**Directory:** `FPU/`

The repository contains `FPU.vhd` and `GenericFPU.vhd`, but both files are empty placeholders.

**Status: Not yet implemented.**

## Sequential Circuits

### Flip-Flops

**Directory:** `Sequential Circuits/Flip-Flop/`

Implemented files:

- `DFlipFlop.vhd`
- `JKFlipFlop.vhd`
- `TFlipFlop.vhd`

The T flip-flop follows the conventional behavior: `T = 0` holds the state and `T = 1` toggles it.

### Register File

**Directory:** `Sequential Circuits/File Register/`

#### 32 × 64-bit Register File

`FileRegister32R64B.vhd` defines a register file with 32 64-bit registers, two asynchronous read ports, one synchronous write port, and 5-bit addresses.

#### Register File with Clear

`FileRegister32R64BWithClear.vhd` adds a synchronous clear operation for the register bank.

### Parallel Load Registers

**Directory:** `Sequential Circuits/Register/Parallel Load Register/`

Fixed-width 4-, 8-, 16-, 32-, and 64-bit implementations are present, along with `GenericPLRegister`.

### Shift Registers

**Directory:** `Sequential Circuits/Register/Shift Register/`

The repository contains a 4-bit left shift register and a 4-bit right shift register.

### Universal Shift Registers

**Directory:** `Sequential Circuits/Register/Universal Shift Register/`

Fixed-width 4-, 8-, 16-, 32-, and 64-bit implementations are present, along with `GenericUSRegister`.

The documented control modes are:

| `S` | Operation |
|---|---|
| `00` | Hold |
| `01` | Parallel load |
| `10` | Shift toward LSB |
| `11` | Shift toward MSB |

Check the individual source files for exact serial-input and bit-direction conventions.

### Counters

**Directory:** `Sequential Circuits/Register/Counter/`

BCD counters:

- `BCDUpCounter.vhd`
- `BCDDownCounter.vhd`

Up/down counters:

- Fixed 4-bit, 8-bit, and 16-bit implementations
- `GenericUpDownCounter.vhd`

### Program Counter

**Directory:** `Sequential Circuits/Register/PC Register/`

The repository contains 32-bit and 64-bit PC registers plus `GenericPCRegister.vhd`. The generic implementation exposes configurable width and instruction width and supports reset, load, and increment control.

## Custom Types

### DataArray

**Source:** `Costume Types/DataArray.vhd`

Defines an unconstrained array type for vectors of data:

```vhdl
TYPE DataArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
```

It is used by the Generic Bus to represent an array of input words.

## Current Status

| Component | Current repository status |
|---|---|
| Decoders, 1-to-2 through 6-to-64 | Source files present |
| MUXes, 2-to-1 through 64-to-1 | Source files present |
| Greater-priority encoders, 2-to-1 through 64-to-6 | Source files present |
| Smaller-priority encoders, 2-to-1 through 64-to-6 | Source files present |
| 1-bit Full Adder | Source file present |
| Generic Signed Adder/Subtractor | Present; source review needed |
| Generic Unsigned Adder/Subtractor | Source file present |
| Fixed 64-bit ALU | Source file present |
| Generic ALU | Source file present; operation mapping needs verification |
| 64-bit Enable-Based Barrel Shifter | Source file present |
| Generic Bus | Source file present |
| Generic Signed Multiplier | Source file present |
| Generic Unsigned Multiplier | Source file present |
| Generic Signed Divider | Source file present |
| Generic Unsigned Divider | Source file present |
| FPU / Generic FPU | Empty placeholders; not implemented |
| D / JK / T Flip-Flops | Source files present |
| 32 × 64-bit Register File | Source file present |
| Register File with Clear | Source file present |
| Parallel Load Registers, 4/8/16/32/64-bit | Source files present |
| Generic Parallel Load Register | Source file present |
| 4-bit Left and Right Shift Registers | Source files present |
| Universal Shift Registers, 4/8/16/32/64-bit | Source files present |
| Generic Universal Shift Register | Source file present |
| BCD Up/Down Counters | Source files present |
| Up/Down Counters, 4/8/16-bit | Source files present |
| Generic Up/Down Counter | Source file present |
| 32-bit and 64-bit PC Registers | Source files present |
| Generic PC Register | Source file present |
| DataArray Package | Source file present |

**Status terminology:** “Source file present” means that a file exists in the repository; it is not a claim that the design has passed compilation, simulation, synthesis, or hardware testing.

## Generic RTL Direction

Current generic modules include:

```text
GenericALU
GenericSignedAdderSubtractor
GenericUnsignedAdderSubtractor
GenericSignedMultiplier
GenericUnsignedMultiplier
GenericSignedDivider
GenericUnsignedDivider
GenericBus
GenericPLRegister
GenericUSRegister
GenericUpDownCounter
GenericPCRegister
```

The overall direction is to reduce duplicated fixed-width RTL and make datapath blocks reusable through VHDL generics.

## Design Concepts Practiced

- Entity and architecture structure
- Combinational and clocked sequential RTL
- `std_logic` and `std_logic_vector`
- `signed`, `unsigned`, and IEEE `numeric_std`
- Boolean and bitwise logic
- Arithmetic and signed/unsigned comparisons
- Carry and overflow signals
- Decoding, multiplexing, and priority encoding
- Shifts and rotates
- Flip-flops and registers
- Register-file organization
- BCD and up/down counters
- Program-counter structures
- Parameterized RTL
- Signed and unsigned multiplication/division
- Quotient and remainder outputs
- Unconstrained VHDL array types
- Datapath-oriented hardware organization

## Libraries

The designs primarily use:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

The Generic Bus also imports the local `DataArray` package.

## Development Roadmap

```text
Basic Combinational Logic
    ↓
Decoders / MUXes / Priority Encoders
    ↓
Arithmetic Building Blocks
    ↓
Flip-Flops / Registers / Counters
    ↓
Register File / Program Counter
    ↓
ALU and Generic Datapath Components
    ↓
Multiplier / Divider Integration
    ↓
FPU Development
    ↓
Future CPU / FPGA Integration
```

## Implementation Notes

- The source tree is the authority for which modules currently exist.
- Fixed-width modules are being complemented by generic implementations.
- Some newly added arithmetic RTL needs compilation and functional review; file presence alone does not guarantee correctness.
- The FPU files are empty placeholders.
- No complete processor or FPGA top-level integration is currently documented in this repository.

## Purpose

This repository is an **educational VHDL laboratory** for developing practical RTL, digital-design, arithmetic-datapath, and processor-design skills through progressively more reusable hardware components.
