-- Generic Up/Down Counter
-- Counts upward or downward according to the select signal
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericUpDownCounter IS
    GENERIC (
        Width : POSITIVE := 16
    );
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        S : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0)
    );
END ENTITY GenericUpDownCounter;

-- Architecture of Up/Down Counter
ARCHITECTURE Struct OF GenericUpDownCounter IS

    SIGNAL QR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

BEGIN
    ASSERT Width >= 1
    REPORT "Width must be greater than or equal to 1."
        SEVERITY FAILURE;

    PROCESS (CLK)
    BEGIN

        IF S = '0' THEN
            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (OTHERS => '0');

            ELSIF rising_edge(CLK) AND QR = (OTHERS => '1') THEN
                QR <= (OTHERS => '0');

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(to_unsigned(1, Width) + unsigned(QR));

            END IF;

        ELSE
            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (OTHERS => '1');

            ELSIF rising_edge(CLK) AND QR = (OTHERS => '0') THEN
                QR <= (OTHERS => '1');

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(unsigned(QR) - to_unsigned(1, Width));

            END IF;
        END IF;

    END PROCESS;

    Q <= QR;

END Struct;