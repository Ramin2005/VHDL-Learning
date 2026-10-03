-- Generic Bus
-- Selects one input according to the select signal
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DataArray.ALL;

ENTITY GenericBus IS
    GENERIC (
        DataWidth : POSITIVE := 64;
        AddressWidth : POSITIVE := 16;
        NumberOfInputs : POSITIVE := 2 ** AddressWidth
    );
    PORT (
        Inputs : IN DataArray(NumberOfInputs - 1DOWNTO 0)(DataWidth - 1 DOWNTO 0);
        Enable : IN STD_LOGIC;
        S : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        O : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0)
    );
END ENTITY GenericBus;

ARCHITECTURE Struct OF GenericBus IS
BEGIN

    O <= Inputs(to_integer(unsigned(S))) AND (DataWidth - 1 DOWNTO 0 => Enable);

END Struct;