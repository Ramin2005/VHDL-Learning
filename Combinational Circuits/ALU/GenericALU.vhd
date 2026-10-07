-- Generic ALU
-- Arithmetic Logic Unit for logic, compare, arithmetic, shift and rotate operations

-- Operations:
-- Logic Operations:
-- not      -> opcode: "000000"
-- and      -> opcode: "000001"
-- or       -> opcode: "000010"
-- xor      -> opcode: "000011"
-- nand     -> opcode: "000100"
-- nor      -> opcode: "000101"
-- xnor     -> opcode: "000110"

-- Compare Operations:
-- A == B   -> opcode: "000111"
-- A != B   -> opcode: "001000"
-- A < B    -> opcode: "001001"
-- A > B    -> opcode: "001010"
-- A <= B   -> opcode: "001011"
-- A >= B   -> opcode: "001100"

-- Arithmetic Operations:
-- Mul      -> opcode: "010000"
-- UnMul    -> opcode: "010001"
-- Div      -> opcode: "010010"
-- UnDiv    -> opcode: "010011"
-- ADD      -> opcode: "010100"
-- UnADD    -> opcode: "010101"
-- SUB      -> opcode: "010110"
-- UnSUB    -> opcode: "010111"
-- INC      -> opcode: "011000"
-- UnINC    -> opcode: "011001"
-- DEC      -> opcode: "011010"
-- UnDEC    -> opcode: "011011"
-- NEG      -> opcode: "011100"
-- UnNEG    -> opcode: "011101"

-- Shift and Rotating Operations:
-- SHL      -> opcode: "011110"
-- SHR      -> opcode: "011111"
-- ASR      -> opcode: "100000"
-- ROL      -> opcode: "100001"
-- ROR      -> opcode: "100010"

-- Buffer   -> opcode: "111111"
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
        S : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        Cout : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC
    );
END ENTITY GenericALU;

-- Architecture of GenericALU
ARCHITECTURE struct OF GenericALU IS
    -- Logic result signals
    SIGNAL ResultNOT : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultAND : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultXOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNAND : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultXNOR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

    -- Compare result signals
    SIGNAL ResultEQ : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultNE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultG : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultLE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultGE : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

    -- Arithmetic result signals
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
    SIGNAL ResultSHL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultSHR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultASR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultROL : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL ResultROR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL CoutASR : STD_LOGIC;
    SIGNAL CoutSHL : STD_LOGIC;
    SIGNAL CoutSHR : STD_LOGIC;

    -- Temporary signal
    SIGNAL USTemp : unsigned(Width - 1 DOWNTO 0);

    -- Enable and Select Signals
    SIGNAL Enable : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    -- Width must be at least 2 for the shift and rotate operations
    ASSERT Width >= 2
    REPORT "Width must be greater than or equal to 2."
        SEVERITY FAILURE;

    ------------------------------------------------------------------------------------------
    -- Logic Operations
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
    TempADD <= unsigned('0' & A) + unsigned('0' & B);
    ResultADD <= STD_LOGIC_VECTOR(TempADD)(Width - 1 DOWNTO 0);
    CoutADD <= TempADD(Width);
    OverflowADD <= (NOT A(Width - 1) AND NOT B(Width - 1) AND ResultADD(Width - 1))
        OR (A(Width - 1) AND B(Width - 1) AND NOT ResultADD(Width - 1));

    TempSUB <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, Width + 1);
    ResultSUB <= STD_LOGIC_VECTOR(TempSUB)(Width - 1 DOWNTO 0);
    CoutSUB <= TempSUB(Width);
    OverflowSUB <= (NOT A(Width - 1) AND B(Width - 1) AND ResultSUB(Width - 1))
        OR (A(Width - 1) AND NOT B(Width - 1) AND NOT ResultSUB(Width - 1));

    TempINC <= unsigned('0' & A) + to_unsigned(1, Width + 1);
    ResultINC <= STD_LOGIC_VECTOR(TempINC)(Width - 1 DOWNTO 0);
    CoutINC <= TempINC(Width);
    OverflowINC <= (NOT A(Width - 1) AND ResultINC(Width - 1));

    USTemp <= (OTHERS => '1');
    TempDEC <= unsigned('0' & A) + unsigned('0' & USTemp);
    ResultDEC <= STD_LOGIC_VECTOR(TempDEC)(Width - 1 DOWNTO 0);
    CoutDEC <= TempDEC(Width);
    OverflowDEC <= (A(Width - 1) AND NOT ResultDEC(Width - 1));

    TempNEG <= unsigned('0' & (NOT A)) + to_unsigned(1, Width + 1);
    ResultNEG <= STD_LOGIC_VECTOR(TempNEG)(Width - 1 DOWNTO 0);
    CoutNEG <= TempNEG(Width);
    OverflowNEG <= '1' WHEN A = (Width - 1 => '1', OTHERS => '0') ELSE
        '0';
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Shift and Rotating operations
    ResultSHL <= A(Width - 2 DOWNTO 0) & '0';
    CoutSHL <= A(Width - 1);

    ResultSHR <= '0' & A(Width - 1 DOWNTO 1);
    CoutSHR <= A(0);

    ResultASR <= A(Width - 1) & A(Width - 1 DOWNTO 1);
    CoutASR <= A(0);

    ResultROL <= A(Width - 2 DOWNTO 0) & A(Width - 1);

    ResultROR <= A(0) & A(Width - 1 DOWNTO 1);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 32), to_integer(unsigned(S))))
        WHEN (unsigned(S) <= 12) OR ((unsigned(S) >= 16) AND (unsigned(S) <= 25)) ELSE
        x"80000000";
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
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
    Overflow <=
        (OverflowADD AND Enable(16))
        OR (OverflowSUB AND Enable(17))
        OR (OverflowINC AND Enable(18))
        OR (OverflowDEC AND Enable(19))
        OR (OverflowNEG AND Enable(20));

END struct;