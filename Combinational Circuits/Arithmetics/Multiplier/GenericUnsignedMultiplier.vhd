LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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

    SIGNAL TempUnsignedA : Unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL TempUnsignedB : Unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL Result : Unsigned(2 * WIDTH - 1 DOWNTO 0);

BEGIN

    TempUnsignedA <= Unsigned(A);
    TempUnsignedB <= Unsigned(B);

    Result <= TempUnsignedA * TempUnsignedB;

    PRODUCT <= STD_LOGIC_VECTOR(Result);

END ARCHITECTURE Struct;