-- BCD Up Counter
-- Counts from 0 to 9 and then returns to 0
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
    -- QR stores the current register or counter state
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Update the state on the rising edge of the clock
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (3 DOWNTO 0 => '0');

        -- Return to zero after reaching decimal 9
        ELSIF rising_edge(CLK) AND QR = "1001" THEN
            QR <= (3 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) THEN
            QR <= STD_LOGIC_VECTOR(to_unsigned(1, 4) + unsigned(QR));

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;