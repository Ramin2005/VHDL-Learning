-- D Flip-Flop
-- Stores the input value on the rising edge of the clock
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

-- Architecture of D Flip-Flop
ARCHITECTURE Struct OF DFlipFlop IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC;

BEGIN
    -- Clocked D flip-flop

    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) THEN
            -- Capture input D on the rising edge of the clock

            QR <= D;

        END IF;

    END PROCESS;

    Q <= QR;
    NQ <= NOT QR;

END Struct;