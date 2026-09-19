-- 64-bit ALU

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

-- Shift and Routing Operation:
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

ENTITY ALU IS
    PORT (
        A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Cin : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        Cout : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC
    );
END ENTITY ALU;

-- Architecture of ALU
ARCHITECTURE struct OF ALU IS
    -- Signal for logic Operations
    SIGNAL ResultNOT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultXOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultXNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Signal for compare operations
    SIGNAL ResultEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNE : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultG : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultLE : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultGE : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Signal for arithmetic Operations
    SIGNAL TempADD : unsigned(64 DOWNTO 0);
    SIGNAL TempSUB : unsigned(64 DOWNTO 0);
    SIGNAL TempINC : unsigned(64 DOWNTO 0);
    SIGNAL TempDEC : unsigned(64 DOWNTO 0);
    SIGNAL TempNEG : unsigned(64 DOWNTO 0);
    SIGNAL ResultADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSUB : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultINC : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultDEC : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNEG : STD_LOGIC_VECTOR(63 DOWNTO 0);
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

    -- Signal for shift and routing Operations
    SIGNAL ResultSHL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSHR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultASR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL CoutASR : STD_LOGIC;
    SIGNAL CoutSHL : STD_LOGIC;
    SIGNAL CoutSHR : STD_LOGIC;

    -- Temporary Signal
    SIGNAL USTemp : unsigned(63 DOWNTO 0);

    -- Enable and Select Signals
    SIGNAL Enable : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    ------------------------------------------------------------------------------------------
    -- Logic Operations
    -- NOT operation
    ResultNOT <= NOT A;
    -- AND operation
    ResultAND <= A AND B;
    -- OR operation
    ResultOR <= A OR B;
    -- XOR operation
    ResultXOR <= A XOR B;
    -- NAND operation
    ResultNAND <= A NAND B;
    -- NOR operation
    ResultNOR <= A NOR B;
    -- XNOR operation
    ResultXNOR <= A XNOR B;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Compare operations
    -- EQ compare operation
    ResultEQ <= (0 => '1', OTHERS => '0') WHEN A = B ELSE
        (OTHERS => '0');

    -- NE compare operation
    ResultNE <= (OTHERS => '0') WHEN A = B ELSE
        (0 => '1', OTHERS => '0');

    -- A < B compare operation
    ResultL <= (0 => '1', OTHERS => '0') WHEN signed(A) < signed(B) ELSE
        (OTHERS => '0');

    -- A > B compare operation
    ResultG <= (0 => '1', OTHERS => '0') WHEN signed(A) > signed(B) ELSE
        (OTHERS => '0');

    -- A <= B compare operation
    ResultLE <= (0 => '1', OTHERS => '0') WHEN signed(A) <= signed(B) ELSE
        (OTHERS => '0');

    -- A >= B compare operation
    ResultGE <= (0 => '1', OTHERS => '0') WHEN signed(A) >= signed(B) ELSE
        (OTHERS => '0');
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Arithmetic operations
    -- ADD operation
    TempADD <= unsigned('0' & A) + unsigned('0' & B);
    ResultADD <= STD_LOGIC_VECTOR(TempADD)(63 DOWNTO 0);
    CoutADD <= TempADD(64);
    OverflowADD <= (NOT A(63) AND NOT B(63) AND ResultADD(63))
        OR (A(63) AND B(63) AND NOT ResultADD(63));

    -- SUB operation
    TempSUB <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65);
    ResultSUB <= STD_LOGIC_VECTOR(TempSUB)(63 DOWNTO 0);
    CoutSUB <= TempSUB(64);
    OverflowSUB <= (NOT A(63) AND B(63) AND ResultSUB(63))
        OR (A(63) AND NOT B(63) AND NOT ResultSUB(63));

    -- INC operation
    TempINC <= unsigned('0' & A) + to_unsigned(1, 65);
    ResultINC <= STD_LOGIC_VECTOR(TempINC)(63 DOWNTO 0);
    CoutINC <= TempINC(64);
    OverflowINC <= (NOT A(63) AND ResultINC(63));

    -- DEC operation
    USTemp <= (OTHERS => '1');
    TempDEC <= unsigned('0' & A) + unsigned('0' & USTemp);
    ResultDEC <= STD_LOGIC_VECTOR(TempDEC)(63 DOWNTO 0);
    CoutDEC <= TempDEC(64);
    OverflowDEC <= (NOT A(63) AND NOT ResultDEC(63));

    -- NEG operation
    TempNEG <= unsigned('0' & (NOT A)) + to_unsigned(1, 65);
    ResultNEG <= STD_LOGIC_VECTOR(TempNEG)(63 DOWNTO 0);
    CoutNEG <= TempNEG(64);
    OverflowNEG <= '1' WHEN A = x"8000000000000000" ELSE
        '0';
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Shift and Routing operations
    -- SHL operation
    ResultSHL <= A(62 DOWNTO 0) & '0';
    CoutSHL <= A(63);

    -- SHR operation
    ResultSHR <= '0' & A(63 DOWNTO 1);
    CoutSHR <= A(0);

    -- ASR operation
    ResultASR <= A(63) & A(63 DOWNTO 1);
    CoutASR <= A(0);

    -- ROL operation 
    ResultROL <= A(62 DOWNTO 0) & A(63);

    -- ROR operation
    ResultROR <= A(0) & A(63 DOWNTO 1);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 32), to_integer(unsigned(S))))
        WHEN (unsigned(S) <= 12) OR ((unsigned(S) >= 16) AND (unsigned(S) <= 25)) ELSE
        x"80000000";
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
    -- Multiplexing Results to Result
    Result <=
        -- Logic operations
        (ResultNOT AND (63 DOWNTO 0 => Enable(0)))
        OR (ResultAND AND (63 DOWNTO 0 => Enable(1)))
        OR (ResultOR AND (63 DOWNTO 0 => Enable(2)))
        OR (ResultXOR AND (63 DOWNTO 0 => Enable(3)))
        OR (ResultNAND AND (63 DOWNTO 0 => Enable(4)))
        OR (ResultNOR AND (63 DOWNTO 0 => Enable(5)))
        OR (ResultXNOR AND (63 DOWNTO 0 => Enable(6)))
        -- Compare operations
        OR (ResultEQ AND (63 DOWNTO 0 => Enable(7)))
        OR (ResultNE AND (63 DOWNTO 0 => Enable(8)))
        OR (ResultL AND (63 DOWNTO 0 => Enable(9)))
        OR (ResultG AND (63 DOWNTO 0 => Enable(10)))
        OR (ResultLE AND (63 DOWNTO 0 => Enable(11)))
        OR (ResultGE AND (63 DOWNTO 0 => Enable(12)))
        -- Arithmetic operations
        OR (ResultADD AND (63 DOWNTO 0 => Enable(16)))
        OR (ResultSUB AND (63 DOWNTO 0 => Enable(17)))
        OR (ResultINC AND (63 DOWNTO 0 => Enable(18)))
        OR (ResultDEC AND (63 DOWNTO 0 => Enable(19)))
        OR (ResultNEG AND (63 DOWNTO 0 => Enable(20)))
        -- Shift and Routing operations
        OR (ResultSHL AND (63 DOWNTO 0 => Enable(21)))
        OR (ResultSHR AND (63 DOWNTO 0 => Enable(22)))
        OR (ResultASR AND (63 DOWNTO 0 => Enable(23)))
        OR (ResultROL AND (63 DOWNTO 0 => Enable(24)))
        OR (ResultROR AND (63 DOWNTO 0 => Enable(25)))
        -- Buffer and invalid opcodes
        OR (A AND (63 DOWNTO 0 => Enable(31)));

    -- Multiplexing Cout
    Cout <=
        -- Arithmetic operations
        (CoutADD AND Enable(16))
        OR (CoutSUB AND Enable(17))
        OR (CoutINC AND Enable(18))
        OR (CoutDEC AND Enable(19))
        OR (CoutNEG AND Enable(20))
        -- Shift and Routing operations
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
    ------------------------------------------------------------------------------------------

END struct;