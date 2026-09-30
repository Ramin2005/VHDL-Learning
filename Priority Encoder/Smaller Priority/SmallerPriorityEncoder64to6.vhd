LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SmallerPriorityEncoder64to6 IS
    PORT (
        D : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        A : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        Valid : OUT STD_LOGIC
    );
END ENTITY SmallerPriorityEncoder64to6;

ARCHITECTURE Struct OF SmallerPriorityEncoder64to6 IS
BEGIN

    PROCESS (D)
    BEGIN

        A <= (5 downto 0 => '0');

        FOR i IN 0 TO 63 LOOP
            IF D(i) = '1' THEN
                A <= STD_LOGIC_VECTOR(to_unsigned(i, 6));
                EXIT;
            END IF;
        END LOOP;

    END PROCESS;

    Valid <= '0' WHEN D = (63 DOWNTO 0 => '0') ELSE
        '1';

END Struct;