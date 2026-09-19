-- Full Adder
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY FA IS
    PORT (
        A, B : IN STD_LOGIC;
        Cin : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC
    );
END ENTITY FA;

ARCHITECTURE struct OF FA IS
BEGIN
    S <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
END struct;