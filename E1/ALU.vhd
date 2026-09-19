-- 64-bit ALU

-- Operations:
-- Logic Operations: 
-- not  -> opcode: "00000"
-- and  -> opcode: "00001"
-- or   -> opcode: "00010"
-- xor  -> opcode: "00011"
-- nand -> opcode: "00100"
-- nor  -> opcode: "00101"
-- xnor -> opcode: "00110"

-- Compare Operations:
-- A == B -> opcode: "00111"
-- A != B -> opcode: "01000"
-- A < B  -> opcode: "01001"
-- A > B  -> opcode: "01010"
-- A <= B -> opcode: "01011"
-- A >= B -> opcode: "01100"

-- Arithmetic Operations:
-- ADD -> opcode: "10000"
-- SUB -> opcode: "10001"

-- Invalid opcode -> don't cares (Buffers)

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
        Cout : OUT STD_LOGIC <= '0';
        Overflow : OUT STD_LOGIC <= '0';
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
    SIGNAL ResultNEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultG : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultLEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultGEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);

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

    SIGNAL USTemp : unsigned(63 DOWNTO 0);
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

    -- NEQ compare operation
    ResultNEQ <= (OTHERS => '0') WHEN A = B ELSE
        (0 => '1', OTHERS => '0');

    -- A < B compare operation
    ResultL <= (0 => '1', OTHERS => '0') WHEN signed(A) < signed(B) ELSE
        (OTHERS => '0');

    -- A > B compare operation
    ResultG <= (0 => '1', OTHERS => '0') WHEN signed(A) > signed(B) ELSE
        (OTHERS => '0');

    -- A <= B compare operation
    ResultLEQ <= (0 => '1', OTHERS => '0') WHEN signed(A) <= signed(B) ELSE
        (OTHERS => '0');

    -- A >= B compare operation
    ResultGEQ <= (0 => '1', OTHERS => '0') WHEN signed(A) >= signed(B) ELSE
        (OTHERS => '0');
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Arithmetic operations
    -- ADD operation
    ResultADD <= STD_LOGIC_VECTOR((unsigned('0' & A) + unsigned('0' & B))(63 DOWNTO 0));
    CoutADD <= unsigned('0' & A) + unsigned('0' & B)(64);
    OverflowADD <= (NOT A(63) AND NOT B(63) AND ResultADD(63))
        OR (A(63) AND B(63) AND NOT ResultADD(63));

    -- SUB operation
    ResultSUB <= STD_LOGIC_VECTOR((unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65))(63 DOWNTO 0));
    CoutSUB <= (unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65))(64);
    OverflowSUB <= (NOT A(63) AND B(63) AND ResultSUB(63))
        OR (A(63) AND NOT B(63) AND NOT ResultSUB(63));

    -- INC operation
    ResultINC <= STD_LOGIC_VECTOR((unsigned('0' & A) + to_unsigned(1, 65))(63 DOWNTO 0));
    CoutINC <= (unsigned('0' & A) + to_unsigned(1, 65))(64);
    OverflowINC <= (NOT A(63) AND ResultINC(63));

    -- DEC operation
    USTemp <= (OTHERS => '1');
    ResultDEC <= STD_LOGIC_VECTOR((unsigned('0' & A) + unsigned('0' & USTemp))(63 DOWNTO 0));
    CoutDEC <= (unsigned('0' & A) + unsigned('0' & USTemp))(64);
    OverflowDEC <= (NOT A(63) AND ResultDEC(63));

    -- NEG operation
    ResultNEG <= STD_LOGIC_VECTOR((unsigned('0' & (NOT A)) + to_unsigned(1, 65))(63 DOWNTO 0));
    CoutNEG <= (unsigned('0' & (NOT A)) + to_unsigned(1, 65))(64);
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

END struct;