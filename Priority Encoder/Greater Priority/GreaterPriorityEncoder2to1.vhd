-- Priority Encoder
-- Selects the highest-index active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GreaterPriorityEncoder2to1 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY GreaterPriorityEncoder2to1;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF GreaterPriorityEncoder2to1 IS
BEGIN
    -- Priority encoding process

    PROCESS (D)
    BEGIN

        A <= (0 downto 0 => '0');

        -- Default output is zero when no input is active
        -- Search inputs from the highest index to the lowest index

        FOR i IN 1 DOWNTO 0 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 1));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (1 DOWNTO 0 => '0') ELSE
        '1';

END Struct;