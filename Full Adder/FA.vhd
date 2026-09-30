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

-- Architecture of Full Adder
ARCHITECTURE struct OF FA IS
BEGIN
    -- Sum operation
    S <= A XOR B XOR Cin;
    -- Carry operation
    Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);

END struct;