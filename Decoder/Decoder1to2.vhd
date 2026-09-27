LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder1to2 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(0 downto 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY Decoder1to2;

ARCHITECTURE Struct OF Decoder1to2 IS

BEGIN

    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 2), to_integer(unsigned(A))))
        AND (1 DOWNTO 0 => E);

END Struct;