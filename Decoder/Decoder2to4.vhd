-- Decoder
-- Converts a binary input into a one-hot output
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder2to4 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY Decoder2to4;

-- Architecture of Decoder
ARCHITECTURE Struct OF Decoder2to4 IS
BEGIN
    -- Decode input value into one-hot output
    -- Enable controls whether the decoder output is active
    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 4), to_integer(unsigned(A))))
        AND (3 DOWNTO 0 => E);

END Struct;