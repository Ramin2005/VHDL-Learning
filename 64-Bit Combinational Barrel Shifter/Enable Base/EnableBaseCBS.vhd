-- 64-bit Combinational Barrel Shifter and Rotating Unit
-- Operations:
-- SHL -> Opcode: "000"
-- SHR -> Opcode: "001"
-- ASL -> Opcode: "010"
-- ASR -> Opcode: "011"
-- ROL -> Opcode: "100"
-- ROR -> Opcode: "101"
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

ARCHITECTURE Struct OF EnableBaseCBS IS
    -- SHL result signal
    SIGNAL ResultSHL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    -- SHR result signal
    SIGNAL ResultSHR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    -- ASR result signal
    SIGNAL ResultASR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    -- ROL result signal
    SIGNAL ResultROL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    -- ROR result signal
    SIGNAL ResultROR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Enable and Select Signals
    SIGNAL Enable : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
    ------------------------------------------------------------------------------------------
    -- SHL result
    ResultSHL <= STD_LOGIC_VECTOR(SHIFT_LEFT(unsigned(A), to_integer(unsigned(S1))));
    -- SHR result
    ResultSHR <= STD_LOGIC_VECTOR(SHIFT_RIGHT(unsigned(A), to_integer(unsigned(S1))));
    -- ASR result
    ResultASR <= STD_LOGIC_VECTOR(SHIFT_RIGHT(signed(A), to_integer(unsigned(S1))));
    -- ROL result
    ResultROL <= STD_LOGIC_VECTOR(ROTATE_LEFT(unsigned(A), to_integer(unsigned(S1))));
    -- ROR result
    ResultROR <= STD_LOGIC_VECTOR(ROTATE_RIGHT(unsigned(A), to_integer(unsigned(S1))));
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 7), to_integer(unsigned(S2))))
        WHEN (unsigned(S2) <= 5 AND unsigned(S1) > 0) ELSE
        "1000000";
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
    -- Multiplexing Results to Result
    Result <=
        -- Shift and Rotating operations
        (ResultSHL AND (63 DOWNTO 0 => Enable(0)))
        OR (ResultSHR AND (63 DOWNTO 0 => Enable(1)))
        OR (ResultSHL AND (63 DOWNTO 0 => Enable(2)))
        OR (ResultASR AND (63 DOWNTO 0 => Enable(3)))
        OR (ResultROL AND (63 DOWNTO 0 => Enable(4)))
        OR (ResultROR AND (63 DOWNTO 0 => Enable(5)))
        -- Buffer and invalid opcodes
        OR (A AND (63 DOWNTO 0 => Enable(6)));
    ------------------------------------------------------------------------------------------

END Struct;