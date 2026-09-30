LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PLRegister64Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY PLRegister64Bit;

ARCHITECTURE Struct OF PLRegister64Bit IS
    SIGNAL QR : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN

    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (63 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

        END IF;

        Q <= QR;

    END PROCESS;

END Struct;