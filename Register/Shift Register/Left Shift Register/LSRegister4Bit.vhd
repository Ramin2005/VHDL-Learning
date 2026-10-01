
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY LSRegister4Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        SI : IN STD_LOGIC;
        SO : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY LSRegister4Bit;

ARCHITECTURE Struct OF LSRegister4Bit IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Reset the stored state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (3 DOWNTO 0 => '0');

            -- 
        ELSIF rising_edge(CLK) THEN
            QR <= SI & QR(3 DOWNTO 1);

        END IF;

    END PROCESS;

    -- Output the stored state
    Q <= QR;

    -- Output the least and most significant state bits
    SO <= QR(0);

END Struct;