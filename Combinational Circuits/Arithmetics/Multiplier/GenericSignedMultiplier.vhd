LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericSignedMultiplier IS
    GENERIC (
        WIDTH : POSITIVE := 64
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        PRODUCT : OUT STD_LOGIC_VECTOR(2 * WIDTH - 1 DOWNTO 0)
    );
END ENTITY GenericSignedMultiplier;

-- 
ARCHITECTURE Struct OF GenericSignedMultiplier IS
BEGIN

    PRODUCT <= STD_LOGIC_VECTOR(signed(A) * signed(B));

END ARCHITECTURE Struct;