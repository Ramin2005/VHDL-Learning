LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder5to32 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(4 downto 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Decoder5to32;

ARCHITECTURE Struct OF Decoder5to32 IS

BEGIN

    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 32), to_integer(unsigned(A))))
        AND (31 DOWNTO 0 => E);

END Struct;