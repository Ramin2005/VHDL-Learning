-- Priority Encoder
-- Selects the highest-index active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GreaterPriorityEncoder32to5 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY GreaterPriorityEncoder32to5;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF GreaterPriorityEncoder32to5 IS
BEGIN

    PROCESS (D)
    BEGIN

        A <= (4 DOWNTO 0 => '0');

        FOR i IN 31 DOWNTO 0 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 5));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    -- Valid indicates whether at least one input is active
    Valid <= '0' WHEN D = (31 DOWNTO 0 => '0') ELSE
        '1';

END Struct;