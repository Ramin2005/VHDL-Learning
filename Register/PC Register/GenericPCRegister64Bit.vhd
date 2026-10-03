
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PCRegister64Bit IS
    GENERIC (
        Width : POSITIVE := 64;
        InstructionWidth : POSITIVE := 4
    );
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        Increment : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0)
    );
END ENTITY PCRegister64Bit;

ARCHITECTURE Struct OF PCRegister32Bit IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN

        -- Reset the stored state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (OTHERS => '0');

            -- Load input data when Load is active
        ELSIF rising_edge(CLK) AND Load = '1' THEN
            QR <= Data;

            -- Increment the stored state
        ELSIF rising_edge(CLK) AND Increment = '1' THEN
            QR <= STD_LOGIC_VECTOR(to_unsigned(InstructionWidth, Width) + unsigned(QR));

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;