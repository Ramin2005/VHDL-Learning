LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericUnsignedMultiplier IS
    GENERIC (
        WIDTH : POSITIVE := 64
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        PRODUCT : OUT STD_LOGIC_VECTOR(2 * WIDTH - 1 DOWNTO 0)
    );

END ENTITY GenericUnsignedMultiplier;

-- 
ARCHITECTURE Struct OF GenericUnsignedMultiplier IS
BEGIN

    PRODUCT <= STD_LOGIC_VECTOR(unsigned(A) * unsigned(B));

END ARCHITECTURE Struct;