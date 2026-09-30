-- Parallel Load Register
-- Stores input data when Load is active
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

    -- Signals
    -- QR stores the current register state
    SIGNAL QR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Update the state on the rising edge of the clock
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (31 DOWNTO 0 => '0');

        -- Load input data when Load is active
        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;