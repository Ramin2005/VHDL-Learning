-- Universal Shift Register
-- Supports hold, parallel load, shift right and shift left operations
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GenericUSRegister IS
    GENERIC (
        Width : POSITIVE := 32
    );
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        SI : IN STD_LOGIC;
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);
        QSL : OUT STD_LOGIC;
        QSR : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(Width - 1 DOWNTO 0)
    );
END ENTITY GenericUSRegister;

-- Architecture of Universal Shift Register
ARCHITECTURE Struct OF GenericUSRegister IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

BEGIN

    -- Clocked register process
    PROCESS (CLK)
    BEGIN
        -- Reset the stored state
        IF rising_edge(CLK) AND Reset = '1' THEN
            QR <= (OTHERS => '0');

            -- Parallel load operation
        ELSIF rising_edge(CLK) AND S = "01" THEN
            QR <= Data;

            -- Shift toward the least significant bit
        ELSIF rising_edge(CLK) AND S = "10" THEN
            QR <= QR(Width - 2 DOWNTO 0) & SI;

            -- Shift toward the most significant bit
        ELSIF rising_edge(CLK) AND S = "11" THEN
            QR <= SI & QR(Width - 1 DOWNTO 1);

        END IF;

    END PROCESS;

    -- Output the stored state
    Q <= QR;

    -- Output the least and most significant state bits
    QSL <= QR(Width - 1);
    QSR <= QR(0);

END Struct;