LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PLRegister32Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY PLRegister32Bit;

ARCHITECTURE Struct OF PLRegister32Bit IS
    SIGNAL QR : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (31 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;