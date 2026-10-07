LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericSignedAdderSubtractor IS
    GENERIC (
        Width : POSITIVE := 64
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        S : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        CarryOut, Overflow : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Struct OF GenericSignedAdderSubtractor IS

    SIGNAL TempAdd : unsigned(width DOWNTO 0);
    SIGNAL ResultTempAddTempAdd : STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
    SIGNAL CoutADD : STD_LOGIC;
    SIGNAL OverflowADD : STD_LOGIC;

    SIGNAL TempSub : unsigned(width DOWNTO 0);
    SIGNAL ResultTempAddTempSub : STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
    SIGNAL CoutSub : STD_LOGIC;
    SIGNAL OverflowSub : STD_LOGIC;

BEGIN

    TempADD <= unsigned('0' & A) + unsigned('0' & B);
    ResultADD <= STD_LOGIC_VECTOR(TempADD)(Width - 1 DOWNTO 0);
    CoutADD <= TempADD(Width);
    OverflowADD <= (NOT A(Width - 1) AND NOT B(Width - 1) AND ResultADD(Width - 1))
        OR (A(Width - 1) AND B(Width - 1) AND NOT ResultADD(Width - 1));

    TempSUB <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, Width + 1);
    ResultSUB <= STD_LOGIC_VECTOR(TempSUB)(Width - 1 DOWNTO 0);
    CoutSUB <= TempSUB(Width);
    OverflowSUB <= (NOT A(Width - 1) AND B(Width - 1) AND ResultSUB(Width - 1))
        OR (A(Width - 1) AND NOT B(Width - 1) AND NOT ResultSUB(Width - 1));

    Result <=
        (ResultADD AND (Width - 1 DOWNTO 0 => NOT S))
        OR (ResultSUB AND (Width - 1 DOWNTO 0 => S));

    Cout <=
        (CoutADD AND NOT S)
        OR (CoutSUB AND S);

    Overflow <=
        (OverflowADD AND NOT S)
        OR (OverflowSUB AND S);

END Struct;