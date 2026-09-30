LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY USRegister64Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        SI : IN STD_LOGIC;
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        QSL : OUT STD_LOGIC;
        QSR : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY USRegister64Bit;

ARCHITECTURE Struct OF USRegister64Bit IS

    -- Signals
    SIGNAL QR : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN

    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (63 DOWNTO 0 => '0');

        ELSIF rising_edge(CLK) AND S = "01" THEN
            QR <= Data;

        ELSIF rising_edge(CLK) AND S = "10" THEN
            QR <= QR(62 DOWNTO 0) & SI;

        ELSIF rising_edge(CLK) AND S = "11" THEN
            QR <= SI & QR(63 DOWNTO 1);

        END IF;

    END PROCESS;

    Q <= QR;
    QSL <= QR(63);
    QSR <= QR(0);

END Struct;