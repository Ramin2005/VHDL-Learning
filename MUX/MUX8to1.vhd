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

ARCHITECTURE Struct OF MUX8to1 IS

    SIGNAL Enable : STD_LOGIC_VECTOR(7 DOWNTO 0);
    
BEGIN

    Enable <= STD_LOGIC_VECTOR(SHIFT_LEFT(to_unsigned(1, 8), to_integer(unsigned(S))));

    O <=
        (Inputs(0) AND Enable(0))
        OR (Inputs(1) AND Enable(1))
        OR (Inputs(2) AND Enable(2))
        OR (Inputs(3) AND Enable(3))
        OR (Inputs(4) AND Enable(4))
        OR (Inputs(5) AND Enable(5))
        OR (Inputs(6) AND Enable(6))
        OR (Inputs(7) AND Enable(7));

END Struct;