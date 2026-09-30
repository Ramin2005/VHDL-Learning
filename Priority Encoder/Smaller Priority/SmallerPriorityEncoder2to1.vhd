-- Priority Encoder
-- Selects the lowest priority active input
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SmallerPriorityEncoder2to1 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY SmallerPriorityEncoder2to1;

-- Architecture of Priority Encoder
ARCHITECTURE Struct OF SmallerPriorityEncoder2to1 IS
BEGIN

    -- Priority encoding process
    PROCESS (D)
    BEGIN

        -- Default output when no input is active
        A <= (0 downto 0 => '0');
        
        -- Search inputs according to priority
        FOR i IN 0 TO 1 LOOP
            -- Stop at the first active input
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