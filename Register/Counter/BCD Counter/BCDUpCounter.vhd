LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY BCDUpCounter IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY BCDUpCounter;

ARCHITECTURE Struct OF BCDUpCounter IS

    -- Signals
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (3 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) AND QR = "1001" THEN
            QR <= (3 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) THEN
            QR <= STD_LOGIC_VECTOR(to_unsigned(1, 4) + unsigned(QR));

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;