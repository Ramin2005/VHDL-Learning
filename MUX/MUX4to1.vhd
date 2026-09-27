LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUX4to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        O : OUT STD_LOGIC
    );
END ENTITY MUX4to1;

ARCHITECTURE Struct OF MUX4to1 IS
BEGIN

    O <=
        (Inputs(0) AND NOT S(1) AND NOT S(0))
        OR (Inputs(1) AND NOT S(1) AND S(0))
        OR (Inputs(2) AND S(1) AND NOT S(0))
        OR (Inputs(0) AND S(1) AND S(0));

END Struct;