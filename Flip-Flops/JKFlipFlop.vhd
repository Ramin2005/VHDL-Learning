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

ARCHITECTURE Struct OF JKFlipFlop IS

    -- Signals
    SIGNAL QR : STD_LOGIC := '0';

BEGIN

    PROCESS (CLK)
    BEGIN

        IF rising_edge(CLK) THEN

            IF J = '0' AND K = '0' THEN
                QR <= QR;

            ELSIF J = '0' AND K = '1' THEN
                QR <= '0';

            ELSIF J = '1' AND K = '0' THEN
                QR <= '1';
            ELSIF J = '1' AND K = '1' THEN
                QR <= NOT QR;

            END IF;

        END IF;

    END PROCESS;

    Q <= QR;
    NQ <= NOT QR;

END Struct;