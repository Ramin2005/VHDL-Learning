LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericSignedDivider IS
    GENERIC (
        WIDTH : POSITIVE := 64
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        QUOTIENT : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        REMAINDER : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)
    );
END ENTITY GenericSignedDivider;

--
ARCHITECTURE Struct OF GenericSignedDivider IS
BEGIN

    QUOTIENT <= STD_LOGIC_VECTOR(signed(A) / signed(B));
    REMAINDER <= STD_LOGIC_VECTOR(signed(A) MOD signed(B));

END ARCHITECTURE Struct;