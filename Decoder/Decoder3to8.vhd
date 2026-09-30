-- Decoder
-- Converts a binary input into a one-hot output
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder3to8 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY Decoder3to8;

-- Architecture of Decoder
ARCHITECTURE Struct OF Decoder3to8 IS
BEGIN
    -- Decode input value into one-hot output
    -- Enable controls whether the decoder output is active
    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 8), to_integer(unsigned(A))))
        AND (7 DOWNTO 0 => E);

END Struct;