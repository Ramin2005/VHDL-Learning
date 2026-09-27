# VHDL Learning

A collection of **VHDL digital-design implementations** developed to practice combinational hardware design and translate digital-logic concepts into synthesizable VHDL descriptions.

The repository currently contains three main hardware blocks:

- **1-bit Full Adder**
- **64-bit ALU**
- **64-bit Combinational Barrel Shifter and Rotating Unit**

The projects are standalone digital-design exercises rather than a complete processor or FPGA application.

## Projects

### 1. Full Adder

**Source:** `Full Adder/FA.vhd`

A 1-bit full adder with two operands (`A`, `B`), carry-in (`Cin`), sum (`S`), and carry-out (`Cout`). The implementation uses the standard Boolean equations for sum and carry.

### 2. 64-bit ALU

**Source:** `ALU/ALU.vhd`

A combinational 64-bit Arithmetic Logic Unit controlled by a 5-bit opcode.

#### Logic operations

| Operation | Opcode |
|---|---|
| NOT | `00000` |
| AND | `00001` |
| OR | `00010` |
| XOR | `00011` |
| NAND | `00100` |
| NOR | `00101` |
| XNOR | `00110` |

#### Comparison operations

| Operation | Opcode |
|---|---|
| A = B | `00111` |
| A ≠ B | `01000` |
| A < B | `01001` |
| A > B | `01010` |
| A ≤ B | `01011` |
| A ≥ B | `01100` |

The relational comparisons are implemented using signed comparison.

#### Arithmetic operations

| Operation | Opcode |
|---|---|
| ADD | `10000` |
| SUB | `10001` |
| INC | `10010` |
| DEC | `10011` |
| NEG | `10100` |

The arithmetic datapath uses 65-bit intermediate signals where required and exposes `Cout` and `Overflow` outputs.

#### Shift and rotate operations

| Operation | Opcode |
|---|---|
| SHL | `10101` |
| SHR | `10110` |
| ASR | `10111` |
| ROL | `11000` |
| ROR | `11001` |

Opcode `11111` provides a buffer/pass-through operation. Unused opcodes are also routed to this behavior.

### 3. 64-bit Combinational Barrel Shifter and Rotating Unit

**Source:** `64-Bit Combinational Barrel Shifter/Enable Base/EnableBaseCBS.vhd`

A dedicated 64-bit combinational shift/rotate unit controlled by a 6-bit shift amount (`S1`) and a 3-bit operation selector (`S2`).

| Operation | Opcode |
|---|---|
| SHL | `000` |
| SHR | `001` |
| ASL | `010` |
| ASR | `011` |
| ROL | `100` |
| ROR | `101` |

The implementation uses `numeric_std` shift/rotate operations and an enable-based selection structure. Invalid operation codes use a buffer/pass-through path.

> **Implementation note:** In the current source, the `ASL` selection uses the same left-shift result as `SHL`.

## Repository Structure

```text
VHDL-Learning/
├── Full Adder/
│   └── FA.vhd
│
├── ALU/
│   └── ALU.vhd
│
├── 64-Bit Combinational Barrel Shifter/
│   ├── Enable Base/
│   │   └── EnableBaseCBS.vhd
│   └── Mux Base/
│       ├── 64to1Mux.vhd
│       └── MuxBaseCBS.vhd
│
└── README.md
```

The `Enable Base` version is currently the substantive barrel-shifter implementation. The `Mux Base` directory represents an alternative MUX-oriented implementation that is still under development.

## Design Focus

The current repository is primarily focused on **combinational digital design**. It provides practice with:

- VHDL entity and architecture structure
- `std_logic` and `std_logic_vector`
- `numeric_std`
- `unsigned` and `signed` arithmetic
- Boolean and bitwise operations
- Arithmetic and overflow handling
- Comparators
- Shift and rotate operations
- Opcode-based datapath selection
- Combinational multiplexing
- Modular digital hardware design

## Design Progression

```text
1-bit Full Adder
       │
       ▼
64-bit ALU
       │
       ▼
64-bit Shift / Rotate Unit
```

These designs provide basic building blocks that can later be integrated into larger datapaths and digital systems.

## Tools and Simulation

The source files use standard IEEE VHDL libraries:

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
```

The designs can be analyzed with VHDL-compatible tools such as **GHDL**, **ModelSim/Questa**, or FPGA vendor tools such as **Vivado** and **Quartus**.

The repository currently does not include a dedicated simulator project, waveform configuration, or automated testbench suite, so simulation setup is tool-dependent.

## Current Status

| Component | Status |
|---|---|
| 1-bit Full Adder | Implemented |
| 64-bit ALU | Implemented |
| 64-bit Barrel Shifter — Enable Base | Implemented |
| Barrel Shifter — MUX Base | Under development |
| Automated Testbenches | Not currently included |

## Future Development

Potential extensions include:

- Completing the MUX-based barrel-shifter implementation
- Adding dedicated VHDL testbenches
- Adding simulation waveforms and verification cases
- Adding sequential logic such as registers and counters
- Building a register file
- Integrating the ALU with other datapath components
- FPGA synthesis and resource/timing reports

## Purpose

This repository is an **educational VHDL laboratory** for developing practical digital-design skills. The emphasis is on implementing hardware blocks in VHDL and understanding how arithmetic, logic, comparison, shift, rotate, and selection operations map onto combinational digital hardware.

## License

This repository is intended for educational and experimental use.
