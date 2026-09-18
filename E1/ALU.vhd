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
        Result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0) <= (OTHERS => '0');
        Cout : OUT STD_LOGIC <= '0';
        Overflow : OUT STD_LOGIC <= '0';
        Zero : OUT STD_LOGIC <= '0'
    );
END ENTITY ALU;
-- Architecture of ALU
ARCHITECTURE struct OF ALU IS
    SIGNAL LVTemp : STD_LOGIC_VECTOR(63 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL STempA : signed(63 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL STempB : signed(63 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL USTempA : unsigned(63 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL USTempB : unsigned(63 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL USTempS : unsigned(64 DOWNTO 0) <= (OTHERS => '0');
BEGIN
    CASE S IS
            -- not operation
        WHEN "00000" =>
            Result <= NOT A;

            -- and operation
        WHEN "00001" =>
            Result <= A AND B;

            -- or operation
        WHEN "00010" =>
            Result <= A OR B;

            -- xor operation
        WHEN "00011" =>
            Result <= A XOR B;

            -- nand operation
        WHEN "00100" =>
            Result <= A NAND B;

            -- nor operation
        WHEN "00101" =>
            Result <= A NOR B;

            -- xnor operation
        WHEN "00110" =>
            Result <= A XNOR B;

            -- A == B compare operation
        WHEN "00111" =>
            IF A = B THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

            -- A != B compare operation
        WHEN "01000" =>
            IF A = B THEN
                Result <= (0 => '0', OTHERS => '0');
            ELSE
                Result <= (0 => '1', OTHERS => '0');
            END IF;

            -- A < B compare operation
        WHEN "01001" =>
            STempA <= signed(A);
            STempB <= signed(B);
            IF STempA < STempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

            -- A > B compare operation
        WHEN "01010" =>
            STempA <= signed(A);
            STempB <= signed(B);
            IF STempA > STempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

            -- A <= B compare operation
        WHEN "01011" =>
            STempA <= signed(A);
            STempB <= signed(B);

            IF STempA <= STempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

            -- A >= B compare operation
        WHEN "01100" =>
            STempA <= signed(A);
            STempB <= signed(B);

            IF STempA >= STempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

            -- ADD operation
        WHEN "10000" =>
            USTempS <= unsigned('0' & A) + unsigned('0' & B);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND NOT B(63) AND Result(63))
                OR (A(63) AND B(63) AND NOT Result(63));

            IF Result = LVTemp THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;

            -- SUB operation
        WHEN "10001" =>
            USTempS <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND B(63) AND Result(63))
                OR (A(63) AND NOT B(63) AND NOT Result(63));

            IF Result = LVTemp THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;

            -- INC operation
        WHEN "100010" =>
            USTempS <= unsigned('0' & A) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));

            IF Result = LVTemp THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;

            -- DEC operation
        WHEN "10011" =>
            USTempA <= (OTHERS => 1)
                USTempS <= unsigned('0' & A) + unsigned('0' & USTempA);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));

            IF Result = LVTemp THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;

            -- NEG operation
        WHEN "10100" =>
            USTempS <= unsigned('0' & (NOT A)) + to_unsigned(1, 65);
            Result <= STD_LOGIC_VECTOR(USTempS(63 DOWNTO 0));
            Cout <= USTempS(64);
            Overflow <= (NOT A(63) AND Result(63));

            IF Result = LVTemp THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;

            -- don't cares (Buffer)
        WHEN OTHERS =>
            Result <= A;
    END CASE;
END struct;