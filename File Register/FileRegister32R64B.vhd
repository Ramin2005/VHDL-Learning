-- File Register
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY FileRegister32R64B IS
    PORT (
        AddressA, AddressB, AddressW : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        WriteEnable : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        DataIn : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        DataOutA, DataOutB : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY FileRegister32R64B;

ARCHITECTURE Struct OF FileRegister32R64B IS

    TYPE DataArray IS ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL Data : DataArray;

BEGIN

    PROCESS (Clk)
    BEGIN

        IF rising_edge(CLK) AND WriteEnable = '1' THEN

            Data(to_integer(unsigned(AddressW))) <= DataIn;

        END IF;

    END PROCESS;

    DataOutA <= Data(to_integer(unsigned(AddressA)));
    DataOutB <= Data(to_integer(unsigned(AddressB)));

END Struct;