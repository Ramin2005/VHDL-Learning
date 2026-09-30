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
    -- QR stores the current flip-flop state
    SIGNAL QR : STD_LOGIC;

BEGIN

    -- Clocked D flip-flop
    PROCESS (CLK)
    BEGIN
    
        -- Capture D on the rising edge of the clock
        IF rising_edge(CLK) THEN

            QR <= D;

        END IF;

    END PROCESS;

    -- Output the stored state and its complement
    Q <= QR;
    NQ <= NOT QR;

END Struct;