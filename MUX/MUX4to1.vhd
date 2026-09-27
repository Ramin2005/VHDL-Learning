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

    O <= Inputs(to_integer(unsigned(S)));

END Struct;