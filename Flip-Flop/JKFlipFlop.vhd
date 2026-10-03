-- JK Flip-Flop
-- Updates the stored state according to J and K on the rising edge of the clock
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY JKFlipFlop IS
    PORT (
        CLK : IN STD_LOGIC;
        J : IN STD_LOGIC;
        K : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        NQ : OUT STD_LOGIC
    );
END ENTITY JKFlipFlop;

-- Architecture of JK Flip-Flop
ARCHITECTURE Struct OF JKFlipFlop IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC := '0';

BEGIN

    -- Clocked flip-flop process
    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) THEN
            -- Update the stored state

            -- Hold the stored state
            IF J = '0' AND K = '0' THEN
                QR <= QR;

                -- Reset the stored state
            ELSIF J = '0' AND K = '1' THEN
                QR <= '0';

                -- Set the stored state
            ELSIF J = '1' AND K = '0' THEN
                QR <= '1';

                -- Toggle the stored state
            ELSIF J = '1' AND K = '1' THEN
                QR <= NOT QR;

            END IF;

        END IF;

    END PROCESS;

    Q <= QR;
    NQ <= NOT QR;

END Struct;