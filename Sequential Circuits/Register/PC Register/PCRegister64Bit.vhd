-- 64-bit Program Counter Register
-- Stores program counter state with reset, load and increment controls
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PCRegister64Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Increment : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY PCRegister64Bit;

-- Architecture of Program Counter Register
ARCHITECTURE Struct OF PCRegister64Bit IS

    SIGNAL QR : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN

    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (OTHERS => '0');

        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

        ELSIF rising_edge(CLK) AND Increment = '1' THEN
            QR <= STD_LOGIC_VECTOR(to_unsigned(4, 64) + unsigned(QR));

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;