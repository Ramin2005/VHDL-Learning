-- Parallel Load Register
-- Stores input data when Load is active
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PLRegister16Bit IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY PLRegister16Bit;

-- Architecture of Parallel Load Register
ARCHITECTURE Struct OF PLRegister16Bit IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
BEGIN
    -- Clocked register process

    PROCESS (CLK)
    BEGIN

        -- Reset the stored state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (15 DOWNTO 0 => '0');

        -- Load input data when Load is active
        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;