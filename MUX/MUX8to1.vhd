-- Multiplexer
-- Selects one input according to the select signal
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUX8to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        O : OUT STD_LOGIC
    );
END ENTITY MUX8to1;

-- Architecture of Multiplexer
ARCHITECTURE Struct OF MUX8to1 IS
BEGIN
    -- Multiplexing operation
    O <= Inputs(to_integer(unsigned(S)));

END Struct;