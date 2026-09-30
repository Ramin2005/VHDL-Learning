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

ARCHITECTURE Struct OF SmallerPriorityEncoder4to2 IS

BEGIN

    PROCESS (D)
    BEGIN

        A <= (1 DOWNTO 0 => '0');

        FOR i IN 0 TO 3 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 2));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    Valid <= '0' WHEN D = (3 DOWNTO 0 => '0') ELSE
        '1';

END Struct;