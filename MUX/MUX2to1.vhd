LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- 2-to-1 Multiplexer
-- Selects one input according to the select signal

ENTITY MUX2to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        S : IN STD_LOGIC;
        O : OUT STD_LOGIC
    );
END ENTITY MUX2to1;

-- Architecture of Multiplexer
ARCHITECTURE Struct OF MUX2to1 IS
BEGIN
    -- Multiplexing operation
    O <=
        (Inputs(0) AND NOT S)
        OR (Inputs(1) AND S);

END Struct;