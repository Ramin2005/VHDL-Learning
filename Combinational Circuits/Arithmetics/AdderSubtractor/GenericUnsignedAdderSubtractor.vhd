LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericUnsignedAdderSubtractor IS

    GENERIC (
        Width : POSITIVE := 64
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        S : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        CarryOut : OUT STD_LOGIC
    );

END ENTITY GenericUnsignedAdderSubtractor;

ARCHITECTURE Struct OF GenericUnsignedAdderSubtractor IS

    SIGNAL TempADD : UNSIGNED(Width DOWNTO 0);
    SIGNAL ResultADD : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL CoutADD : STD_LOGIC;

    SIGNAL TempSUB : UNSIGNED(Width DOWNTO 0);
    SIGNAL ResultSUB : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
    SIGNAL CoutSUB : STD_LOGIC;

BEGIN

    TempADD <= UNSIGNED('0' & A) + UNSIGNED('0' & B);

    ResultADD <= STD_LOGIC_VECTOR(TempADD(Width - 1 DOWNTO 0));

    CoutADD <= TempADD(Width);
    TempSUB <= UNSIGNED('0' & A)
        + UNSIGNED('0' & (NOT B))
        + TO_UNSIGNED(1, Width + 1);

    ResultSUB <= STD_LOGIC_VECTOR(TempSUB(Width - 1 DOWNTO 0));

    CoutSUB <= TempSUB(Width);

    Result <=
        (ResultADD AND (Width - 1 DOWNTO 0 => NOT S))
        OR
        (ResultSUB AND (Width - 1 DOWNTO 0 => S));

    CarryOut <=
        (CoutADD AND NOT S)
        OR
        (CoutSUB AND S);

END ARCHITECTURE Struct;