-- 64-bit Combinational Barrel Shifter and Rotating Unit
-- Performs shift and rotate operations using an enable-based multiplexer structure
-- Operations:
-- SHL -> Opcode: "000"
-- SHR -> Opcode: "001"
-- ASR -> Opcode: "010"
-- ROL -> Opcode: "011"
-- ROR -> Opcode: "100"
-- Invalid Opcodes -> Buffer


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY EnableBaseCBS IS
    PORT (
        A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        S2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END ENTITY EnableBaseCBS;

-- Architecture of Barrel Shifter and Rotating Unit
ARCHITECTURE Struct OF EnableBaseCBS IS
    -- Shift and Rotating result signals
    SIGNAL ResultSHL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSHR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultASR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Enable and Select Signals
    SIGNAL Enable : STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN
    ------------------------------------------------------------------------------------------
    -- Shift and Rotating operations
    -- Perform variable-distance shifts and rotations on input A
    -- SHL operation
    ResultSHL <= STD_LOGIC_VECTOR(SHIFT_LEFT(unsigned(A), to_integer(unsigned(S1))));
    -- SHR operation
    ResultSHR <= STD_LOGIC_VECTOR(SHIFT_RIGHT(unsigned(A), to_integer(unsigned(S1))));
    -- ASR operation
    ResultASR <= STD_LOGIC_VECTOR(SHIFT_RIGHT(signed(A), to_integer(unsigned(S1))));
    -- ROL operation
    ResultROL <= STD_LOGIC_VECTOR(ROTATE_LEFT(unsigned(A), to_integer(unsigned(S1))));
    -- ROR operation
    ResultROR <= STD_LOGIC_VECTOR(ROTATE_RIGHT(unsigned(A), to_integer(unsigned(S1))));
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    -- Generate a one-hot enable from the operation selector

    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 6), to_integer(unsigned(S2))))
        WHEN (unsigned(S2) <= 4 AND unsigned(S1) > 0) ELSE
        "100000";
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
    -- Select the active shift or rotate result using the enable signal

    Result <=
        -- Shift and Rotating operations
        (ResultSHL AND (63 DOWNTO 0 => Enable(0)))
        OR (ResultSHR AND (63 DOWNTO 0 => Enable(1)))
        OR (ResultASR AND (63 DOWNTO 0 => Enable(2)))
        OR (ResultROL AND (63 DOWNTO 0 => Enable(3)))
        OR (ResultROR AND (63 DOWNTO 0 => Enable(4)))
        -- Buffer and invalid opcodes
        OR (A AND (63 DOWNTO 0 => Enable(5)));
    ------------------------------------------------------------------------------------------

END Struct;