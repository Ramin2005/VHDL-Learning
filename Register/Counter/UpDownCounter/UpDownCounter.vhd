LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY UpDownCounter IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        S : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY UpDownCounter;

ARCHITECTURE Struct OF UpDownCounter IS

    -- Signals
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    PROCESS (CLK)
    BEGIN

        IF S = '0' THEN

            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (3 DOWNTO 0 => '0');

            ELSIF rising_edge(CLK) AND QR = "1111" THEN
                QR <= (3 DOWNTO 0 => '0');

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(to_unsigned(1, 4) + unsigned(QR));

            END IF;

        ELSE

            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (3 DOWNTO 0 => '0');

            ELSIF rising_edge(CLK) AND QR = "0000" THEN
                QR <= "1111";

            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(unsigned(QR) - to_unsigned(1, 4));

            END IF;

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;