-- 4-bit Right Shift Register
-- Shifts serial input toward the most significant bit on the rising clock edge

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RSRegister4Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        SI : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY RSRegister4Bit;

-- Architecture of Right Shift Register
ARCHITECTURE Struct OF RSRegister4Bit IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Reset the stored state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (OTHERS => '0');

            -- Shift the stored state toward the most significant bit
        ELSIF rising_edge(CLK) THEN
            QR <= QR(2 DOWNTO 0) & SI;

        END IF;

    END PROCESS;

    -- Output the stored state
    Q <= QR;

END Struct;