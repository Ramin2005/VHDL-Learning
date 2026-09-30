-- 64-to-1 Multiplexer
-- Selects one input bit from the input vector
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUX64to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        O : OUT STD_LOGIC
    );
END ENTITY MUX64to1;

-- Architecture of Multiplexer
ARCHITECTURE Struct OF MUX64to1 IS
BEGIN
    -- Multiplexing operation
    O <= Inputs(to_integer(unsigned(S)));

END Struct;