-- Priority Encoder
-- Selects the lowest-index active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SmallerPriorityEncoder4to2 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY SmallerPriorityEncoder4to2;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF SmallerPriorityEncoder4to2 IS
BEGIN
    -- Priority encoding process

    PROCESS (D)
    BEGIN

        A <= (1 DOWNTO 0 => '0');

        -- Default output is zero when no input is active
        -- Search inputs from the lowest index to the highest index

        FOR i IN 0 TO 3 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 2));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (3 DOWNTO 0 => '0') ELSE
        '1';

END Struct;