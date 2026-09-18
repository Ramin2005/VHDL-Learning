LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ALU IS
    PORT (
        A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        Cin : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) <= (OTHERS => '0');
        Cout : OUT STD_LOGIC <= '0';
        Overflow : OUT STD_LOGIC <= '0';
        Zero : OUT STD_LOGIC <= '0'
    );
END ENTITY ALU;

ARCHITECTURE struct OF ALU IS
    SIGNAL Temp : STD_LOGIC_VECTOR(31 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL SignedTempA : signed(31 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL SignedTempB : signed(31 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL UnsignedTempA : unsigned(31 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL UnsignedTempB : unsigned(31 DOWNTO 0) <= (OTHERS => '0');
    SIGNAL TempS : unsigned(32 DOWNTO 0) <= (OTHERS => '0');
BEGIN
    CASE S IS
        WHEN "00000" =>
            Result <= NOT A;

        WHEN "00001" =>
            Result <= A AND B;

        WHEN "00010" =>
            Result <= A OR B;

        WHEN "00011" =>
            Result <= A XOR B;

        WHEN "00100" =>
            Result <= A NAND B;

        WHEN "00101" =>
            Result <= A NOR B;

        WHEN "00110" =>
            Result <= A XNOR B;

        WHEN "00111" =>
            IF A = B THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

        WHEN "01000" =>
            IF A = B THEN
                Result <= (0 => '0', OTHERS => '0');
            ELSE
                Result <= (0 => '1', OTHERS => '0');
            END IF;

        WHEN "01001" =>
            SignedTempA <= signed(A);
            SignedTempB <= signed(B);
            IF SignedTempA < SignedTempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

        WHEN "01010" =>
            SignedTempA <= signed(A);
            SignedTempB <= signed(B);
            IF SignedTempA > SignedTempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

        WHEN "01011" =>
            SignedTempA <= signed(A);
            SignedTempB <= signed(B);

            IF SignedTempA <= SignedTempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

        WHEN "01100" =>
            SignedTempA <= signed(A);
            SignedTempB <= signed(B);

            IF SignedTempA >= SignedTempB THEN
                Result <= (0 => '1', OTHERS => '0');
            ELSE
                Result <= (0 => '0', OTHERS => '0');
            END IF;

        WHEN OTHERS =>
            Result <= A;
    END CASE;
END struct;