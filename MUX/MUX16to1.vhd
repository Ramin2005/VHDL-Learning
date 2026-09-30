LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUX16to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        O : OUT STD_LOGIC
    );
END ENTITY MUX16to1;

ARCHITECTURE Struct OF MUX16to1 IS
BEGIN

    O <= Inputs(to_integer(unsigned(S)));

END Struct;