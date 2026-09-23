# VHDL Learning

A collection of digital-design exercises and hardware implementations written in **VHDL**.

The repository currently focuses on combinational digital logic, starting from a basic full adder and progressing to an ALU and a 64-bit combinational barrel shifter.

## Projects

### Full Adder

**File:** `Full Adder/FA.vhd`

A VHDL implementation of a full-adder building block.

### ALU

**File:** `ALU/ALU.vhd`

A larger VHDL ALU implementation containing the logic required to perform multiple arithmetic/logic operations.

### 64-Bit Combinational Barrel Shifter

The barrel-shifter project is organized into two approaches:

- **Enable Base** — `64-Bit Combinational Barrel Shifter/Enable Base/EnableBaseCBS.vhd`
- **MUX Base** — `64-Bit Combinational Barrel Shifter/Mux Base/MuxBaseCBS.vhd`
- **64-to-1 MUX source** — `64-Bit Combinational Barrel Shifter/Mux Base/64to1Mux.vhd`

The MUX-based files are currently empty placeholders in the repository, while the enable-based implementation contains the current substantive implementation.

## Repository Structure

```text
VHDL-Learning/
├── Full Adder/
│   └── FA.vhd
├── ALU/
│   └── ALU.vhd
├── 64-Bit Combinational Barrel Shifter/
│   ├── Enable Base/
│   │   └── EnableBaseCBS.vhd
│   └── Mux Base/
│       ├── 64to1Mux.vhd
│       └── MuxBaseCBS.vhd
└── README.md
```

## Scope

The repository is currently centered on **combinational digital design** and is useful for studying how hardware blocks can be described structurally and behaviorally in VHDL.

The projects also form useful building blocks for larger digital systems:

```text
Full Adder
    ↓
ALU
    ↓
Barrel Shifter
    ↓
Larger CPU / Digital System
```

## Current Status

| Project | Status |
|---|---|
| Full Adder | Implemented |
| ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| 64-bit Barrel Shifter — MUX Base | Work in progress / placeholder |

## Tools

The repository contains standard `.vhd` VHDL source files. They can be analyzed and simulated with a VHDL-compatible HDL toolchain such as **GHDL**, **Questa/ModelSim**, or an FPGA vendor tool.

No specific simulator project configuration is currently included in the repository, so the exact compile/simulation setup depends on the tool being used.

## Learning Goals

This repository is used to practice:

- VHDL syntax and entity/architecture design
- Combinational logic modeling
- Arithmetic and logical hardware
- Multiplexer-based design
- Barrel-shifter architectures
- Building larger hardware blocks from smaller digital components

## Future Work

Potential extensions include completing the MUX-based barrel shifter and adding testbenches for the existing designs.

## License

This repository is intended for educational and experimental use.
