LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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

    SIGNAL TempUnsignedA : unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL TempUnsignedB : unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL QuotientResult : unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL RemainderResult : unsigned(WIDTH - 1 DOWNTO 0);

BEGIN

    TempUnsignedA <= unsigned(A);
    TempUnsignedB <= unsigned(B);

    QuotientResult <= TempUnsignedA / TempUnsignedB;
    RemainderResult <= TempUnsignedA MOD TempUnsignedB;

    QUOTIENT <= STD_LOGIC_VECTOR(QuotientResult);
    REMAINDER <= STD_LOGIC_VECTOR(RemainderResult);

END ARCHITECTURE Struct;