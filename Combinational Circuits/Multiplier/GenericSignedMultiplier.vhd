LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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

    SIGNAL TempSignedA : signed(WIDTH - 1 DOWNTO 0);
    SIGNAL TempSignedB : signed(WIDTH - 1 DOWNTO 0);
    SIGNAL Result : signed(2 * WIDTH - 1 DOWNTO 0);

BEGIN

    TempSignedA <= signed(A);
    TempSignedB <= signed(B);

    Result <= TempSignedA * TempSignedB;

    PRODUCT <= STD_LOGIC_VECTOR(Result);

END ARCHITECTURE Struct;