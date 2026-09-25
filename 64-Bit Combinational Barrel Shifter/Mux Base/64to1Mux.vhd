LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY 64to1Mux IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        O : OUT STD_LOGIC;
    );
END ENTITY 64to1Mux;

ARCHITECTURE Struct OF 64to1Mux IS
BEGIN
END Struct;