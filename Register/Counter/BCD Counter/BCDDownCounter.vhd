-- BCD Down Counter
-- Counts from 9 to 0 and then returns to 9
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY BCDDownCounter IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY BCDDownCounter;

-- Architecture of BCD Down Counter
ARCHITECTURE Struct OF BCDDownCounter IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Reset the counter state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= "1001";

            -- Return to decimal 9 after reaching zero
        ELSIF rising_edge(CLK) AND QR = "0000" THEN
            QR <= "1001";

            -- Decrement the stored state
        ELSIF rising_edge(CLK) THEN
            QR <= STD_LOGIC_VECTOR(unsigned(QR) - to_unsigned(1, 4));

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;