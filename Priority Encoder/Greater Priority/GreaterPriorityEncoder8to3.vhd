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

ARCHITECTURE Struct OF GreaterPriorityEncoder8to3 IS

BEGIN

    PROCESS (D)
    BEGIN

        A <= (2 downto 0 => '0');

        FOR i IN 7 DOWNTO 0 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    Valid <= '0' WHEN D = (7 DOWNTO 0 => '0') ELSE
        '1';

END Struct;