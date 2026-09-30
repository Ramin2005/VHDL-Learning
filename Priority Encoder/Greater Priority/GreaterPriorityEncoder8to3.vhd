-- Priority Encoder
-- Selects the highest priority active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GreaterPriorityEncoder8to3 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY GreaterPriorityEncoder8to3;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF GreaterPriorityEncoder8to3 IS
BEGIN

    -- Priority encoding process
    PROCESS (D)
    BEGIN

        -- Default output when no input is active
        A <= (2 downto 0 => '0');

        FOR i IN 7 DOWNTO 0 LOOP
            -- Stop at the first active input
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (7 DOWNTO 0 => '0') ELSE
        '1';

END Struct;