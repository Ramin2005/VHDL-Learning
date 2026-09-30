-- 4-bit Up/Down Counter
-- Counts upward or downward according to the select signal
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY UpDownCounter IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        S : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY UpDownCounter;

-- Architecture of Up/Down Counter
ARCHITECTURE Struct OF UpDownCounter IS

    -- Stored state signal
    SIGNAL QR : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN
    -- Clocked counter process

    PROCESS (CLK)
    BEGIN

        -- Select counting direction
        IF S = '0' THEN
            -- Up counting

        -- Reset the counter state
        IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (3 DOWNTO 0 => '0');

            -- Return to zero after reaching maximum value
            ELSIF rising_edge(CLK) AND QR = "1111" THEN
                QR <= (3 DOWNTO 0 => '0');

            -- Increment the stored state
            ELSIF rising_edge(CLK) THEN
                QR <= STD_LOGIC_VECTOR(to_unsigned(1, 4) + unsigned(QR));

            END IF;

        ELSE
            -- Down counting
            IF rising_edge(CLK) AND Reset = '1' THEN
                QR <= (3 DOWNTO 0 => '0');

            -- Return to maximum value after reaching zero
            ELSIF rising_edge(CLK) AND QR = "0000" THEN
                QR <= "1111";

            -- Increment the stored state
            ELSIF rising_edge(CLK) THEN
                -- Decrement the stored state
                QR <= STD_LOGIC_VECTOR(unsigned(QR) - to_unsigned(1, 4));

            END IF;

        END IF;

    END PROCESS;

    Q <= QR;

END Struct;