-- Decoder
-- Converts a binary input into a one-hot output
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decoder6to64 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        E : IN STD_LOGIC;
        D : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY Decoder6to64;

-- Architecture of Decoder
ARCHITECTURE Struct OF Decoder6to64 IS
BEGIN
    -- Decode input value into one-hot output
    -- Enable controls whether the decoder output is active
    D <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 64), to_integer(unsigned(A))))
        AND (63 DOWNTO 0 => E);

END Struct;