LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericAdder IS
    GENERIC (
        Width : POSITIVE := 64
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        CarryIn : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        CarryOut, Overflow : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE Struct OF GenericAdder IS
    SIGNAL Temp : unsigned(width DOWNTO 0);
    SIGNAL Result : STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
    CONSTANT Zero : STD_LOGIC_VECTOR(width - 1 DOWNTO 0) := (others => '0');
BEGIN

    Temp <= unsigned('0' & A) + unsigned('0' & B) + unsigned(Zero & CarryIn);
    Result <= STD_LOGIC_VECTOR(Temp)(Width - 1 DOWNTO 0);
    CarryOut <= Temp(Width);
    Overflow <= (NOT A(Width - 1) AND NOT B(Width - 1) AND Result(Width - 1))
        OR (A(Width - 1) AND B(Width - 1) AND NOT Result(Width - 1));

    S <= Result;
END Struct;