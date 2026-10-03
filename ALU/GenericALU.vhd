-- Arithmetic Logic Unit for logic, compare, arithmetic, shift and rotate operations

-- Operations:
-- Logic Operations:
-- not      -> opcode: "00000"
-- and      -> opcode: "00001"
-- or       -> opcode: "00010"
-- xor      -> opcode: "00011"
-- nand     -> opcode: "00100"
-- nor      -> opcode: "00101"
-- xnor     -> opcode: "00110"

-- Compare Operations:
-- A == B   -> opcode: "00111"
-- A != B   -> opcode: "01000"
-- A < B    -> opcode: "01001"
-- A > B    -> opcode: "01010"
-- A <= B   -> opcode: "01011"
-- A >= B   -> opcode: "01100"

-- Arithmetic Operations:
-- ADD      -> opcode: "10000"
-- SUB      -> opcode: "10001"
-- INC      -> opcode: "10010"
-- DEC      -> opcode: "10011"
-- NEG      -> opcode: "10100"

-- Shift and Rotating Operations:
-- SHL      -> opcode: "10101"
-- SHR      -> opcode: "10110"
-- ASR      -> opcode: "10111"
-- ROL      -> opcode: "11000"
-- ROR      -> opcode: "11001"

-- Buffer   -> opcode: "11111"
-- Out of list opcodes -> Buffer

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericALU IS
    GENERIC (
        Width : POSITIVE := 64
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        Cout : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC
    );
END ENTITY GenericALU;

-- Architecture of GenericALU
ARCHITECTURE struct OF GenericALU IS
    -- Logic result signals
    -- Store the result of each logic operation
    SIGNAL ResultNOT : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultAND : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultXOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNAND : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultXNOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

    -- Compare result signals
    -- Store the result of each comparison operation
    SIGNAL ResultEQ : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultG : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultLE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultGE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

    -- Arithmetic result signals
    -- Temporary signals store extended arithmetic results
    SIGNAL TempADD : unsigned(Width DOWNTO 0);
    SIGNAL TempSUB : unsigned(Width DOWNTO 0);
    SIGNAL TempINC : unsigned(Width DOWNTO 0);
    SIGNAL TempDEC : unsigned(Width DOWNTO 0);
    SIGNAL TempNEG : unsigned(Width DOWNTO 0);
    SIGNAL ResultADD : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultSUB : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultINC : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultDEC : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNEG : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL CoutADD : STD_LOGIC;
    SIGNAL CoutSUB : STD_LOGIC;
    SIGNAL CoutINC : STD_LOGIC;
    SIGNAL CoutDEC : STD_LOGIC;
    SIGNAL CoutNEG : STD_LOGIC;
    SIGNAL OverflowADD : STD_LOGIC;
    SIGNAL OverflowSUB : STD_LOGIC;
    SIGNAL OverflowINC : STD_LOGIC;
    SIGNAL OverflowDEC : STD_LOGIC;
    SIGNAL OverflowNEG : STD_LOGIC;

    -- Shift and Rotating result signals
    -- Store the result and carry of each shift operation
    SIGNAL ResultSHL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultSHR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultASR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultROL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultROR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL CoutASR : STD_LOGIC;
    SIGNAL CoutSHL : STD_LOGIC;
    SIGNAL CoutSHR : STD_LOGIC;

    -- Temporary signal
    -- Used for intermediate unsigned arithmetic operations
    SIGNAL USTemp : unsigned(Width - 1 DOWNTO 0);

    -- Enable and Select Signals
    -- One-hot enable signal selects the active ALU operation
    SIGNAL Enable : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    ASSERT Width >= 2
    REPORT "Width must be greater than or equal to 2."
        SEVERITY FAILURE;
        
    ------------------------------------------------------------------------------------------
    -- Logic Operations
    -- Perform bitwise logic operations on A and B
    -- NOT operation
    ResultNOT <= NOT A;
    ResultAND <= A AND B;
    ResultOR <= A OR B;
    ResultXOR <= A XOR B;
    ResultNAND <= A NAND B;
    ResultNOR <= A NOR B;
    ResultXNOR <= A XNOR B;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Compare operations
    -- EQ compare operation

    ResultEQ <= (0 => '1', OTHERS => '0') WHEN A = B ELSE
        (OTHERS => '0');

    ResultNE <= (OTHERS => '0') WHEN A = B ELSE
        (0 => '1', OTHERS => '0');

    ResultL <= (0 => '1', OTHERS => '0') WHEN signed(A) < signed(B) ELSE
        (OTHERS => '0');

    ResultG <= (0 => '1', OTHERS => '0') WHEN signed(A) > signed(B) ELSE
        (OTHERS => '0');

    ResultLE <= (0 => '1', OTHERS => '0') WHEN signed(A) <= signed(B) ELSE
        (OTHERS => '0');

    ResultGE <= (0 => '1', OTHERS => '0') WHEN signed(A) >= signed(B) ELSE
        (OTHERS => '0');
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Arithmetic operations
    -- Arithmetic operations use extended operands to preserve the carry output
    -- ADD operation
    -- Add A and B and preserve the carry-out bit

    TempADD <= unsigned('0' & A) + unsigned('0' & B);
    ResultADD <= STD_LOGIC_VECTOR(TempADD)(Width - 1 DOWNTO 0);
    CoutADD <= TempADD(Width);
    OverflowADD <= (NOT A(Width - 1) AND NOT B(Width - 1) AND ResultADD(Width - 1))
        OR (A(Width - 1) AND B(Width - 1) AND NOT ResultADD(Width - 1));

    -- SUB operation
    -- Subtract B from A using two's-complement arithmetic
    TempSUB <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, Width + 1);
    ResultSUB <= STD_LOGIC_VECTOR(TempSUB)(Width - 1 DOWNTO 0);
    CoutSUB <= TempSUB(Width);
    OverflowSUB <= (NOT A(Width - 1) AND B(Width - 1) AND ResultSUB(Width - 1))
        OR (A(Width - 1) AND NOT B(Width - 1) AND NOT ResultSUB(Width - 1));

    -- INC operation
    -- Increment A by one
    TempINC <= unsigned('0' & A) + to_unsigned(1, Width + 1);
    ResultINC <= STD_LOGIC_VECTOR(TempINC)(Width - 1 DOWNTO 0);
    CoutINC <= TempINC(Width);
    OverflowINC <= (NOT A(Width - 1) AND ResultINC(Width - 1));

    -- DEC operation
    -- Decrement A by one
    USTemp <= (OTHERS => '1');
    TempDEC <= unsigned('0' & A) + unsigned('0' & USTemp);
    ResultDEC <= STD_LOGIC_VECTOR(TempDEC)(Width - 1 DOWNTO 0);
    CoutDEC <= TempDEC(Width);
    OverflowDEC <= (A(Width - 1) AND NOT ResultDEC(Width - 1));

    -- NEG operation
    -- Negate A using two's-complement arithmetic
    TempNEG <= unsigned('0' & (NOT A)) + to_unsigned(1, Width + 1);
    ResultNEG <= STD_LOGIC_VECTOR(TempNEG)(Width - 1 DOWNTO 0);
    CoutNEG <= TempNEG(Width);
    OverflowNEG <= '1' WHEN A = (Width - 1 => '1', OTHERS => '0') ELSE
        '0';
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Shift and Rotating operations
    -- Perform fixed one-bit shifts and rotations
    -- SHL operation
    -- Shift A left by one bit

    ResultSHL <= A(Width - 2 DOWNTO 0) & '0';
    CoutSHL <= A(Width - 1);

    ResultSHR <= '0' & A(Width - 1 DOWNTO 1);
    -- SHR operation
    -- Logical shift A right by one bit
    CoutSHR <= A(0);

    ResultASR <= A(Width - 1) & A(Width - 1 DOWNTO 1);
    -- ASR operation
    -- Arithmetic shift A right by one bit while preserving the sign bit
    CoutASR <= A(0);

    ResultROL <= A(Width - 2 DOWNTO 0) & A(Width - 1);
    -- ROR operation
    -- Rotate A right by one bit

    ResultROR <= A(0) & A(Width - 1 DOWNTO 1);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    -- Generate a one-hot enable for valid operation codes
    -- Invalid operation codes select the buffer operation

    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 32), to_integer(unsigned(S))))
        WHEN (unsigned(S) <= 12) OR ((unsigned(S) >= 16) AND (unsigned(S) <= 25)) ELSE
        x"80000000";
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
    -- Select the active operation result using the one-hot enable signal

    Result <=
        -- Logic operations
        (ResultNOT AND (Width - 1 DOWNTO 0 => Enable(0)))
        OR (ResultAND AND (Width - 1 DOWNTO 0 => Enable(1)))
        OR (ResultOR AND (Width - 1 DOWNTO 0 => Enable(2)))
        OR (ResultXOR AND (Width - 1 DOWNTO 0 => Enable(3)))
        OR (ResultNAND AND (Width - 1 DOWNTO 0 => Enable(4)))
        OR (ResultNOR AND (Width - 1 DOWNTO 0 => Enable(5)))
        OR (ResultXNOR AND (Width - 1 DOWNTO 0 => Enable(6)))
        -- Compare operations
        OR (ResultEQ AND (Width - 1 DOWNTO 0 => Enable(7)))
        OR (ResultNE AND (Width - 1 DOWNTO 0 => Enable(8)))
        OR (ResultL AND (Width - 1 DOWNTO 0 => Enable(9)))
        OR (ResultG AND (Width - 1 DOWNTO 0 => Enable(10)))
        OR (ResultLE AND (Width - 1 DOWNTO 0 => Enable(11)))
        OR (ResultGE AND (Width - 1 DOWNTO 0 => Enable(12)))
        -- Arithmetic operations
        OR (ResultADD AND (Width - 1 DOWNTO 0 => Enable(16)))
        OR (ResultSUB AND (Width - 1 DOWNTO 0 => Enable(17)))
        OR (ResultINC AND (Width - 1 DOWNTO 0 => Enable(18)))
        OR (ResultDEC AND (Width - 1 DOWNTO 0 => Enable(19)))
        OR (ResultNEG AND (Width - 1 DOWNTO 0 => Enable(20)))
        -- Shift and Rotating operations
        OR (ResultSHL AND (Width - 1 DOWNTO 0 => Enable(21)))
        OR (ResultSHR AND (Width - 1 DOWNTO 0 => Enable(22)))
        OR (ResultASR AND (Width - 1 DOWNTO 0 => Enable(23)))
        OR (ResultROL AND (Width - 1 DOWNTO 0 => Enable(24)))
        OR (ResultROR AND (Width - 1 DOWNTO 0 => Enable(25)))
        -- Buffer and invalid opcodes
        OR (A AND (Width - 1 DOWNTO 0 => Enable(31)));

    -- Multiplexing Cout
    -- Select the carry output of the active arithmetic or shift operation
    Cout <=
        -- Arithmetic operations
        (CoutADD AND Enable(16))
        OR (CoutSUB AND Enable(17))
        OR (CoutINC AND Enable(18))
        OR (CoutDEC AND Enable(19))
        OR (CoutNEG AND Enable(20))
        -- Shift and Rotating operations
        OR (CoutSHL AND Enable(21))
        OR (CoutSHR AND Enable(22))
        OR (CoutASR AND Enable(23));

    -- Multiplexing Overflow
    -- Select the overflow output of the active arithmetic operation

    Overflow <=
        (OverflowADD AND Enable(16))
        OR (OverflowSUB AND Enable(17))
        OR (OverflowINC AND Enable(18))
        OR (OverflowDEC AND Enable(19))
        OR (OverflowNEG AND Enable(20));

END struct;