-- Priority Encoder
-- Selects the highest priority active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GreaterPriorityEncoder64to6 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY GreaterPriorityEncoder64to6;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF GreaterPriorityEncoder64to6 IS
BEGIN

    -- Priority encoding process
    PROCESS (D)
    BEGIN

        -- Default output when no input is active
        A <= (5 downto 0 => '0');

        FOR i IN 63 DOWNTO 0 LOOP
            -- Stop at the first active input
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 6));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (63 DOWNTO 0 => '0') ELSE
        '1';

END Struct;