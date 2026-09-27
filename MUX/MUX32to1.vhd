LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MUX32to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        O : OUT STD_LOGIC
    );
END ENTITY MUX32to1;

ARCHITECTURE Struct OF MUX32to1 IS

    SIGNAL Enable : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    Enable <= STD_LOGIC_VECTOR(SHIFT_LEFT(to_unsigned(1, 32), to_integer(unsigned(S))));

    O <=
        (Inputs(0) AND Enable(0))
        OR (Inputs(1) AND Enable(1))
        OR (Inputs(2) AND Enable(2))
        OR (Inputs(3) AND Enable(3))
        OR (Inputs(4) AND Enable(4))
        OR (Inputs(5) AND Enable(5))
        OR (Inputs(6) AND Enable(6))
        OR (Inputs(7) AND Enable(7))
        OR (Inputs(8) AND Enable(8))
        OR (Inputs(9) AND Enable(9))
        OR (Inputs(10) AND Enable(10))
        OR (Inputs(11) AND Enable(11))
        OR (Inputs(12) AND Enable(12))
        OR (Inputs(13) AND Enable(13))
        OR (Inputs(14) AND Enable(14))
        OR (Inputs(15) AND Enable(15))
        OR (Inputs(16) AND Enable(16))
        OR (Inputs(17) AND Enable(17))
        OR (Inputs(18) AND Enable(18))
        OR (Inputs(19) AND Enable(19))
        OR (Inputs(20) AND Enable(20))
        OR (Inputs(21) AND Enable(21))
        OR (Inputs(22) AND Enable(22))
        OR (Inputs(23) AND Enable(23))
        OR (Inputs(24) AND Enable(24))
        OR (Inputs(25) AND Enable(25))
        OR (Inputs(26) AND Enable(26))
        OR (Inputs(27) AND Enable(27))
        OR (Inputs(28) AND Enable(28))
        OR (Inputs(29) AND Enable(29))
        OR (Inputs(30) AND Enable(30))
        OR (Inputs(31) AND Enable(31));

END Struct;