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
    SIGNAL TempNOT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempXOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempNAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempXNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Signal for compare operations
    SIGNAL TempEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempNEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempG : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempLEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempGEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Signal for arithmetic Operations
    SIGNAL TempADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempSUB : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempINC : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempDEC : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempNEG : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Signal for shift and routing Operations
    SIGNAL TempSHL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL CoutSHL : STD_LOGIC;
    SIGNAL TempSHR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL CoutSHR : STD_LOGIC;
    SIGNAL TempASR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL CoutASR : STD_LOGIC;
    SIGNAL TempROL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL TempROR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    SIGNAL USTempA : unsigned(63 DOWNTO 0);
    SIGNAL USTempB : unsigned(63 DOWNTO 0);
    SIGNAL USTempS : unsigned(64 DOWNTO 0);
BEGIN
    -- Logic Operations
    -- NOT operation
    TempNOT <= NOT A;
    -- AND operation
    TempAND <= A AND B;
    -- OR operation
    TempOR <= A OR B;
    -- XOR operation
    TempXOR <= A XOR B;
    -- NAND operation
    TempNAND <= A NAND B;
    -- NOR operation
    TempNOR <= A NOR B;
    -- XNOR operation
    TempXNOR <= A XNOR B;

    -- Signal for compare operations
    -- EQ and NEQ compare operation
    IF A = B THEN
        TempEQ <= (0 => '1', OTHERS => '0');
        TempNEQ <= (OTHERS => '0');
    ELSE
        TempEQ <= (OTHERS => '0');
        TempNEQ <= (0 => '1', OTHERS => '0');
    END IF;

    -- A < B compare operation
    IF signed(A) < signed(B) THEN
        TempL <= (0 => '1', OTHERS => '0');
    ELSE
        TempL <= (OTHERS => '0');
    END IF;

    -- A > B compare operation
    IF signed(A) > signed(B) THEN
        TempG <= (0 => '1', OTHERS => '0');
    ELSE
        TempG <= (OTHERS => '0');
    END IF;

    -- A <= B compare operation
    IF signed(A) <= signed(B) THEN
        TempLEQ <= (0 => '1', OTHERS => '0');
    ELSE
        TempL <= (OTHERS => '0');
    END IF;

    -- A >= B compare operation
    IF signed(A) >= signed(B) THEN
        TempGEQ <= (0 => '1', OTHERS => '0');
    ELSE
        TempGEQ <= (OTHERS => '0');
    END IF;


    -- Shift and Routing operations
    -- SHL operation
    TempSHL <= A(62 DOWNTO 0) & '0';
    CoutSHL <= A(63);

    -- SHR operation
    TempSHR <= '0' & A(63 DOWNTO 1);
    CoutSHR <= A(0);

    -- ASR operation
    TempASR <= A(63) & A(63 DOWNTO 1);
    CoutASR <= A(0);

    -- ROL operation 
    TempROL <= A(62 DOWNTO 0) & A(63);

    -- ROR operation
    TempROR <= A(0) & A(63 DOWNTO 1);

    CASE S IS
            -- ADD operation
        WHEN "10000" =>
            USTempS <= unsigned('0' & A) + unsigned('0' & B);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND NOT B(63) AND Result(63))
                OR (A(63) AND B(63) AND NOT Result(63));

            -- SUB operation
        WHEN "10001" =>
            USTempS <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND B(63) AND Result(63))
                OR (A(63) AND NOT B(63) AND NOT Result(63));

            -- INC operation
        WHEN "100010" =>
            USTempS <= unsigned('0' & A) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));

            -- DEC operation
        WHEN "10011" =>
            USTempA <= (OTHERS => 1)
                USTempS <= unsigned('0' & A) + unsigned('0' & USTempA);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));

            -- NEG operation
        WHEN "10100" =>
            USTempS <= unsigned('0' & (NOT A)) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));
            -- don't cares (Buffer)
        WHEN OTHERS =>
            Result <= A;
    END CASE;
END struct;