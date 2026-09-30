-- Full Adder
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY FA IS
    -- Input signals and carry input
    -- A and B are the operands
    -- Cin is the input carry
    -- S is the sum output
    -- Cout is the output carry
    PORT (
        A, B : IN STD_LOGIC;
        Cin : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC
    );
END ENTITY FA;

ARCHITECTURE struct OF FA IS
BEGIN
    -- Sum operation
    S <= A XOR B XOR Cin;
    -- Carry operation
    Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
    
END struct;