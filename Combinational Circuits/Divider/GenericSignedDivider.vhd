LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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

    SIGNAL TempSignedA : Signed(WIDTH - 1 DOWNTO 0);
    SIGNAL TempSignedB : Signed(WIDTH - 1 DOWNTO 0);
    SIGNAL QuotientResult : Signed(WIDTH - 1 DOWNTO 0);
    SIGNAL RemainderResult : Signed(WIDTH - 1 DOWNTO 0);

BEGIN

    TempSignedA <= Signed(A);
    TempSignedB <= Signed(B);

    QuotientResult <= TempSignedA / TempSignedB;
    RemainderResult <= TempSignedA MOD TempSignedB;

    QUOTIENT <= STD_LOGIC_VECTOR(QuotientResult);
    REMAINDER <= STD_LOGIC_VECTOR(RemainderResult);

END ARCHITECTURE Struct;