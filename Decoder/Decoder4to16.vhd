LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder4to16 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 downto 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY Decoder4to16;

ARCHITECTURE Struct OF Decoder4to16 IS

BEGIN

    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 16), to_integer(unsigned(A))))
        AND (1 DOWNTO 0 => E);

END Struct;