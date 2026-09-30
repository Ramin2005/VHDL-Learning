LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DFlipFlop IS
    PORT (
        CLK : IN STD_LOGIC;
        D : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        NQ : OUT STD_LOGIC
    );
END ENTITY DFlipFlop;

ARCHITECTURE Struct OF DFlipFlop IS

    -- Signals
    SIGNAL QR : STD_LOGIC;

BEGIN

    PROCESS (CLK)
    BEGIN
    
        IF rising_edge(CLK) THEN

            QR <= D;

        END IF;

    END PROCESS;

    Q <= QR;
    NQ <= NOT QR;

END Struct;