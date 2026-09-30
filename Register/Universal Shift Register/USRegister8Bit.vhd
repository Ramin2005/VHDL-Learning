LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY USRegister8Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        SI : IN STD_LOGIC;
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SO : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY USRegister8Bit;

ARCHITECTURE Struct OF UsRegister8Bit IS
    SIGNAL QR : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (7 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) AND S = "01" THEN
            QR <= Data;

        ELSIF rising_edge(CLK) AND S = "10" THEN
            QR <= QR(6 DOWNTO 0) & SI;
            SO <= QR(7);

        ELSIF rising_edge(CLK) AND S = "11" THEN
            QR <= SI & QR(7 DOWNTO 1);
            SO <= QR(0);

        END IF;

        Q <= QR;

    END PROCESS;

END Struct;