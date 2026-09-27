LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY JKFlipFlop IS
    PORT (
        clk : IN STD_LOGIC;
        j : IN STD_LOGIC;
        k : IN STD_LOGIC;
        q : OUT STD_LOGIC;
        nq : OUT STD_LOGIC
    );
END ENTITY JKFlipFlop;

ARCHITECTURE Struct OF JKFlipFlop IS
    SIGNAL qr : STD_LOGIC := '0';
BEGIN

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN

            IF j = '0' AND k = '0' THEN
                qr <= qr;

            ELSIF j = '0' AND k = '1' THEN
                qr <= '0';

            ELSIF j = '1' AND k = '0' THEN
                qr <= '1';
            ELSIF j = '1' AND k = '1' THEN
                qr <= NOT qr;

            END IF;

        END IF;

        q <= qr;
        q <= NOT qr;

    END PROCESS;

END Struct;