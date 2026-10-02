-- T Flip-Flop
-- Stores the input value on the rising edge of the clock
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY TFlipFlop IS
    PORT (
        CLK : IN STD_LOGIC;
        T : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        NQ : OUT STD_LOGIC
    );
END ENTITY TFlipFlop;

-- Architecture of T Flip-Flop
ARCHITECTURE Struct OF TFlipFlop IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC := '0';

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) THEN
            -- Capture input T on the rising edge of the clock

            QR <= (T AND NOT QR) OR (NOT T AND QR);

        END IF;

    END PROCESS;

    Q <= QR;
    NQ <= NOT QR;

END Struct;