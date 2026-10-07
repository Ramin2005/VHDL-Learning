-- 8-bit Up/Down Counter
-- Counts upward or downward according to the select signal
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY UpDownCounter8Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        S : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY UpDownCounter8Bit;

-- Architecture of Up/Down Counter
ARCHITECTURE Struct OF UpDownCounter8Bit IS

    SIGNAL QR : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    PROCESS (CLK)
    BEGIN

        IF S = '0' THEN
            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (OTHERS => '0');

            ELSIF rising_edge(CLK) AND QR = (OTHERS => '1') THEN
                QR <= (OTHERS => '0');

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(to_unsigned(1, 8) + unsigned(QR));

            END IF;
        ELSE
            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (OTHERS => '1');

            ELSIF rising_edge(CLK) AND QR = (OTHERS => '0') THEN
                QR <= (OTHERS => '1');

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(unsigned(QR) - to_unsigned(1, 8));

            END IF;
        END IF;

    END PROCESS;

    Q <= QR;

END Struct;