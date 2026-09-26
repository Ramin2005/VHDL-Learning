LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Mux64to1 IS
    PORT (
        Inputs : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        O : OUT STD_LOGIC;
    );
END ENTITY Mux64to1;

ARCHITECTURE Struct OF Mux64to1 IS
    SIGNAL Enable : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
    Enable <= STD_LOGIC_VECTOR(SHIFT_LEFT(to_unsigned(1, 64), to_unsigned(S)));

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
        OR (Inputs(31) AND Enable(31))
        OR (Inputs(32) AND Enable(32))
        OR (Inputs(33) AND Enable(33))
        OR (Inputs(34) AND Enable(34))
        OR (Inputs(35) AND Enable(35))
        OR (Inputs(36) AND Enable(36))
        OR (Inputs(37) AND Enable(37))
        OR (Inputs(38) AND Enable(38))
        OR (Inputs(39) AND Enable(39))
        OR (Inputs(40) AND Enable(40))
        OR (Inputs(41) AND Enable(41))
        OR (Inputs(42) AND Enable(42))
        OR (Inputs(43) AND Enable(43))
        OR (Inputs(44) AND Enable(44))
        OR (Inputs(45) AND Enable(45))
        OR (Inputs(46) AND Enable(46))
        OR (Inputs(47) AND Enable(47))
        OR (Inputs(48) AND Enable(48))
        OR (Inputs(49) AND Enable(49))
        OR (Inputs(50) AND Enable(50))
        OR (Inputs(51) AND Enable(51))
        OR (Inputs(52) AND Enable(52))
        OR (Inputs(53) AND Enable(53))
        OR (Inputs(54) AND Enable(54))
        OR (Inputs(55) AND Enable(55))
        OR (Inputs(56) AND Enable(56))
        OR (Inputs(57) AND Enable(57))
        OR (Inputs(58) AND Enable(58))
        OR (Inputs(59) AND Enable(59))
        OR (Inputs(60) AND Enable(60))
        OR (Inputs(61) AND Enable(61))
        OR (Inputs(62) AND Enable(62))
        OR (Inputs(63) AND Enable(63));

END Struct;