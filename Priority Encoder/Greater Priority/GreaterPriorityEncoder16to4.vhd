-- Priority Encoder
-- Selects the highest priority active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GreaterPriorityEncoder16to4 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY GreaterPriorityEncoder16to4;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF GreaterPriorityEncoder16to4 IS
BEGIN

    -- Priority encoding process
    PROCESS (D)
    BEGIN

        -- Default output when no input is active
        A <= (3 downto 0 => '0');

        FOR i IN 15 DOWNTO 0 LOOP
            -- Stop at the first active input
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 4));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (15 DOWNTO 0 => '0') ELSE
        '1';

END Struct;