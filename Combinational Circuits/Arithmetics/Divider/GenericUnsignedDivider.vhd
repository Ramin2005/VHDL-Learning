LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericUnsignedDivider IS
    GENERIC (
        WIDTH : POSITIVE := 64
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        QUOTIENT : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        REMAINDER : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)
    );
END ENTITY GenericUnsignedDivider;

--
ARCHITECTURE Struct OF GenericUnsignedDivider IS
BEGIN

    QUOTIENT <= STD_LOGIC_VECTOR(unsigned(A) / unsigned(B));
    REMAINDER <= STD_LOGIC_VECTOR(unsigned(A) MOD unsigned(B));

END ARCHITECTURE Struct;