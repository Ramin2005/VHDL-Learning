-- RV64IM Base + Custom ALU Extensions
-- ALUControl: 6-bit operation codes

-- Arithmetic Operations:
-- ADD          -> opcode: "000000"(0)
-- SUB          -> opcode: "000001"(1)
-- ADDW         -> opcode: "000010"(2)
-- SUBW         -> opcode: "000011"(3)
-- ABS          -> opcode: "000100"(4)  -- Extended
-- ABSW         -> opcode: "000101"(5)  -- Extended
-- MUL          -> opcode: "000110"(6)  -- Low 64 bits of product
-- MULH         -> opcode: "000111"(7)  -- High 64 bits, signed x signed
-- MULHSU       -> opcode: "001000"(8)  -- High 64 bits, signed x unsigned
-- MULHU        -> opcode: "001001"(9)  -- High 64 bits, unsigned x unsigned
-- MULW         -> opcode: "001010"(10) -- Low 32-bit product, sign-extended
-- DIV          -> opcode: "001011"(11) -- Signed 64-bit quotient
-- DIVU         -> opcode: "001100"(12) -- Unsigned 64-bit quotient
-- DIVW         -> opcode: "001101"(13) -- Signed 32-bit quotient, sign-extended
-- DIVUW        -> opcode: "001110"(14) -- Unsigned 32-bit quotient, sign-extended
-- REM          -> opcode: "001111"(15) -- Signed 64-bit remainder
-- REMU         -> opcode: "010000"(16) -- Unsigned 64-bit remainder
-- REMW         -> opcode: "010001"(17) -- Signed 32-bit remainder, sign-extended
-- REMUW        -> opcode: "010010"(18) -- Unsigned 32-bit remainder, sign-extended

-- Logic Operations:
-- Buffer       -> opcode: "010011"(19) -- Extended
-- NOT          -> opcode: "010100"(20) -- Extended
-- AND          -> opcode: "010101"(21)
-- OR           -> opcode: "010110"(22)
-- XOR          -> opcode: "010111"(23)
-- ANDN         -> opcode: "011000"(24) -- Extended
-- ORN          -> opcode: "011001"(25) -- Extended
-- XORN         -> opcode: "011010"(26) -- Extended
-- NAND         -> opcode: "011011"(27) -- Extended
-- NOR          -> opcode: "011100"(28) -- Extended
-- XNOR         -> opcode: "011101"(29) -- Extended

-- Compare Operations:
-- A == B       -> opcode: "011110"(30) -- Equal
-- A != B       -> opcode: "011111"(31) -- Not Equal
-- A < B        -> opcode: "100000"(32) -- SLT
-- A > B        -> opcode: "100001"(33) -- SGT
-- A <= B       -> opcode: "100010"(34) -- LE
-- A >= B       -> opcode: "100011"(35) -- GE

-- Shift and Rotate Operations:
-- SLL          -> opcode: "100100"(36)
-- SRL          -> opcode: "100101"(37)
-- SRA          -> opcode: "100110"(38)
-- ROL          -> opcode: "100111"(39) -- Extended
-- ROR          -> opcode: "101000"(40) -- Extended
-- SLLW         -> opcode: "101001"(41)
-- SRLW         -> opcode: "101010"(42)
-- SRAW         -> opcode: "101011"(43)
-- ROLW         -> opcode: "101100"(44) -- Extended
-- RORW         -> opcode: "101101"(45) -- Extended

-- Custom Compare Operations:
-- MIN          -> opcode: "101110"(46) -- Extended
-- MINU         -> opcode: "101111"(47) -- Extended
-- MAX          -> opcode: "110000"(48) -- Extended
-- MAXU         -> opcode: "110001"(49) -- Extended

-- Custom Bit Count Operations:
-- CLZ          -> opcode: "110010"(50) -- Extended
-- CTZ          -> opcode: "110011"(51) -- Extended
-- CPOP         -> opcode: "110100"(52) -- Extended

-- Custom Shift and Add Operations:
-- SH1ADD       -> opcode: "110101"(53) -- Extended
-- SH2ADD       -> opcode: "110110"(54) -- Extended
-- SH3ADD       -> opcode: "110111"(55) -- Extended
-- SH4ADD       -> opcode: "111000"(56) -- Extended
-- SH8ADD       -> opcode: "111001"(57) -- Extended

-- Custom Bit Manipulation Operations:
-- BSET         -> opcode: "111010"(58) -- Extended
-- BCLR         -> opcode: "111011"(59) -- Extended
-- BINV         -> opcode: "111100"(60) -- Extended
-- BEXT         -> opcode: "111101"(61) -- Extended

-- Other Custom Operations:
-- REV8         -> opcode: "111110"(62) -- Extended
-- ORC.B        -> opcode: "111111"(63) -- Extended

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ALU IS
    PORT (
        A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        Cout : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC
    );
END ENTITY ALU;

-- Architecture of ALU
ARCHITECTURE struct OF ALU IS

    -- Arithmetic result signals
    SIGNAL ResultADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSUB : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultADDW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSUBW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultABS : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultABSW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMUL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMULH : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMULHSU : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMULHU : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMULW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultDIV : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultDIVU : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultDIVW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultDIVUW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultREM : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultREMU : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultREMW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultREMUW : STD_LOGIC_VECTOR(63 DOWNTO 0);

    SIGNAL CoutADD : STD_LOGIC;
    SIGNAL CoutSUB : STD_LOGIC;
    SIGNAL CoutADDW : STD_LOGIC;
    SIGNAL CoutSUBW : STD_LOGIC;
    SIGNAL OverflowADD : STD_LOGIC;
    SIGNAL OverflowSUB : STD_LOGIC;
    SIGNAL OverflowADDW : STD_LOGIC;
    SIGNAL OverflowSUBW : STD_LOGIC;

    -- Logic result signals
    SIGNAL ResultNOT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultXOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultANDN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultORN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultXORN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNAND : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultXNOR : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Compare result signals
    SIGNAL ResultEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultNEQ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultUnL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultLE : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultUnLE : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Shift and Rotating result signals
    SIGNAL ResultSLL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSRL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSRA : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROL : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSLLW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSRLW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSRAW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultROLW : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultRORW : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Custom Compare result signals
    SIGNAL ResultMIN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMINU : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMAX : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultMAXU : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Custom Bit Count result signals
    SIGNAL ResultCLZ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultCTZ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultCPOP : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Custom Shift and Add result signals
    SIGNAL ResultSH1ADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSH2ADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSH3ADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSH4ADD : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultSH8ADD : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Custom Bit Manipulation result signals
    SIGNAL ResultBSET : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBCLR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBINV : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBEXT : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Other Custom Operations signals
    SIGNAL ResultREV8 : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultORCB : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Temporary signals
    -- 32 Low bits temps
    SIGNAL TempAL : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL TempBL : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Shift and Routing temps
    SIGNAL TempSLLW : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL TempSRLW : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL TempSRAW : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL TempROLW : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL TempRORW : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Arithmetic temps
    SIGNAL TempADD : unsigned(64 DOWNTO 0);
    SIGNAL TempSUB : unsigned(64 DOWNTO 0);
    SIGNAL TempADDW : unsigned(32 DOWNTO 0);
    SIGNAL TempSUBW : unsigned(32 DOWNTO 0);
    SIGNAL TempMULSS : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL TempMULSU : STD_LOGIC_VECTOR(129 DOWNTO 0);
    SIGNAL TempMULUU : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL TempDIVW : signed (31 DOWNTO 0);
    SIGNAL TempDIVUW : unsigned (31 DOWNTO 0);
    SIGNAL TempREM : signed (63 DOWNTO 0);
    SIGNAL TempREMW : signed (31 DOWNTO 0);
    SIGNAL TempREMUW : unsigned (31 DOWNTO 0);
    -- Signed and Unsigned of A, B, AL, BL temps
    SIGNAL TempSA : signed (63 DOWNTO 0);
    SIGNAL TempSB : signed (63 DOWNTO 0);
    SIGNAL TempUA : unsigned (63 DOWNTO 0);
    SIGNAL TempUB : unsigned (63 DOWNTO 0);
    SIGNAL TempSAL : signed (31 DOWNTO 0);
    SIGNAL TempSBL : signed (31 DOWNTO 0);
    SIGNAL TempUAL : unsigned (31 DOWNTO 0);
    SIGNAL TempUBL : unsigned (31 DOWNTO 0);
    -- Abs of Signed of A, B, AL, BL temps
    SIGNAL TempAbsA : signed (63 DOWNTO 0);
    SIGNAL TempAbsB : signed (63 DOWNTO 0);
    SIGNAL TempAbsAL : signed (31 DOWNTO 0);
    SIGNAL TempAbsBL : signed (31 DOWNTO 0);
    -- Custom Shift and Add operations temps
    SIGNAL ResultSH1ADD : signed(64 DOWNTO 0);
    SIGNAL ResultSH2ADD : signed(64 DOWNTO 0);
    SIGNAL ResultSH3ADD : signed(64 DOWNTO 0);
    SIGNAL ResultSH4ADD : signed(64 DOWNTO 0);
    SIGNAL ResultSH8ADD : signed(64 DOWNTO 0);
    -- Result temp
    SIGNAL TempResult : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Enable and Select Signals
    SIGNAL Enable : STD_LOGIC_VECTOR(43 DOWNTO 0);

    -- Zero constant
    CONSTANT TempZero : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '0');
BEGIN

    TempAL <= A(31 DOWNTO 0);
    TempBL <= B(31 DOWNTO 0);
    TempSA <= signed(A);
    TempSB <= signed(B);
    TempUA <= unsigned(A);
    TempUB <= unsigned(B);
    TempSAL <= signed(TempAL);
    TempSBL <= signed(TempBL);
    TempUAL <= unsigned(TempAL);
    TempUBL <= unsigned(TempBL);
    TempAbsA <= ABS(TempSA);
    TempAbsB <= ABS(TempSB);
    TempAbsAL <= ABS(TempSAL);
    TempAbsBL <= ABS(TempSBL);

    ------------------------------------------------------------------------------------------
    -- Arithmetic operations
    TempMULSS <= STD_LOGIC_VECTOR(TempSA * TempSB);
    TempMULSU <= STD_LOGIC_VECTOR(signed(A(63) & A) * signed('0' & B));
    TempMULUU <= STD_LOGIC_VECTOR(TempUA * TempUB);

    -- MUL
    ResultMUL <= TempMULSS(63 DOWNTO 0);

    -- MULH
    ResultMULH <= TempMULSS(127 DOWNTO 64);

    -- MULHSU
    ResultMULHSU <= TempMULSU(127 DOWNTO 64);

    -- MULHU
    ResultMULHU <= TempMULUU(127 DOWNTO 64);

    -- MULW
    ResultMULW <= (63 DOWNTO 32 => TempMULSS(31)) & TempMULSS(31 DOWNTO 0);

    -- DIV
    ResultDIV <= (OTHERS => '1') WHEN TempSB = 0 ELSE
        STD_LOGIC_VECTOR(TempSA / TempSB);

    -- DIVU
    ResultDIVU <= (OTHERS => '1') WHEN TempSB = 0 ELSE
        STD_LOGIC_VECTOR(TempUA / TempUB);

    -- DIVW
    TempDIVW <= TempSAL / TempSBL WHEN TempSBL /= 0 ELSE
        (OTHERS => '0');
    ResultDIVW <= (OTHERS => '1') WHEN TempSBL = 0 ELSE
        (63 DOWNTO 32 => TempDIVW(31)) & STD_LOGIC_VECTOR(TempDIVW(31 DOWNTO 0));

    -- DIVUW
    TempDIVUW <= TempUAL / TempUBL WHEN TempSBL /= 0 ELSE
        (OTHERS => '0');
    ResultDIVUW <= (OTHERS => '1') WHEN TempSBL = 0 ELSE
        (63 DOWNTO 32 => TempDIVUW(31)) & STD_LOGIC_VECTOR(TempDIVUW(31 DOWNTO 0));

    -- REM
    TempREM <= TempAbsA MOD TempAbsB WHEN TempSB /= 0 ELSE
        (OTHERS => '0');
    ResultREM <= A WHEN TempSB = 0 ELSE
        STD_LOGIC_VECTOR(TempREM) WHEN TempSA >= 0 ELSE
        STD_LOGIC_VECTOR(-TempREM);

    -- REMU
    ResultREMU <= A WHEN TempSB = 0 ELSE
        STD_LOGIC_VECTOR(TempUA MOD TempUB);

    -- REMW
    TempREMW <= TempAbsAL MOD TempAbsBL WHEN TempSBL /= 0 ELSE
        (OTHERS => '0');
    ResultREMW <= ((63 DOWNTO 32 => A(31)) & A(31 DOWNTO 0)) WHEN TempSBL = 0 ELSE
        (63 DOWNTO 32 => TempREMW(31)) & STD_LOGIC_VECTOR(TempREMW) WHEN TempSAL >= 0 ELSE
        STD_LOGIC_VECTOR(RESIZE(-TempREMW, 64));

    -- REMUW
    TempREMUW <= TempUAL MOD TempUBL WHEN TempSBL /= 0 ELSE
        (OTHERS => '0');
    ResultREMUW <= ((63 DOWNTO 32 => A(31)) & A(31 DOWNTO 0)) WHEN TempSBL = 0 ELSE
        (63 DOWNTO 32 => TempREMUW(31)) & STD_LOGIC_VECTOR(TempREMUW);

    -- ADD
    TempADD <= unsigned('0' & A) + unsigned('0' & B);
    ResultADD <= STD_LOGIC_VECTOR(TempADD(63 DOWNTO 0));
    CoutADD <= TempADD(64);
    OverflowADD <= (NOT A(63) AND NOT B(63) AND ResultADD(63))
        OR (A(63) AND B(63) AND NOT ResultADD(63));

    -- SUB
    TempSUB <= unsigned('0' & A) + unsigned('0' & (NOT B)) + to_unsigned(1, 65);
    ResultSUB <= STD_LOGIC_VECTOR(TempSUB(63 DOWNTO 0));
    CoutSUB <= TempSUB(64);
    OverflowSUB <= (NOT A(63) AND B(63) AND ResultSUB(63))
        OR (A(63) AND NOT B(63) AND NOT ResultSUB(63));

    -- ADDW
    TempADDW <= unsigned('0' & TempAL) + unsigned('0' & TempBL);
    ResultADDW <= (31 DOWNTO 0 => TempADDW(31)) & STD_LOGIC_VECTOR(TempADDW(31 DOWNTO 0));
    CoutADDW <= TempADDW(32);
    OverflowADDW <= (NOT A(31) AND NOT B(31) AND ResultADDW(31))
        OR (A(31) AND B(31) AND NOT ResultADDW(31));

    -- SUBW
    TempSUBW <= unsigned('0' & TempAL) + unsigned('0' & (NOT TempBL)) + to_unsigned(1, 33);
    ResultSUBW <= (31 DOWNTO 0 => TempSUBW(31)) & STD_LOGIC_VECTOR(TempSUBW(31 DOWNTO 0));
    CoutSUBW <= TempSUBW(32);
    OverflowSUBW <= (NOT A(31) AND B(31) AND ResultSUBW(31))
        OR (A(31) AND NOT B(31) AND NOT ResultSUBW(31));

    -- ABS
    ResultABS <= STD_LOGIC_VECTOR(TempAbsA);

    -- ABSW
    ResultABSW <= (63 DOWNTO 32 => TempAbsAL(31)) & STD_LOGIC_VECTOR(TempAbsAL);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Logic Operations
    -- NOT
    ResultNOT <= NOT A;
    -- AND
    ResultAND <= A AND B;
    -- OR
    ResultOR <= A OR B;
    -- XOR
    ResultXOR <= A XOR B;
    -- ANDN
    ResultANDN <= A AND NOT B;
    -- ORN
    ResultORN <= A OR NOT B;
    -- XORN
    ResultXORN <= A XOR NOT B;
    -- NAND
    ResultNAND <= A NAND B;
    -- NOR
    ResultNOR <= A NOR B;
    -- XNOR
    ResultXNOR <= A XNOR B;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Compare operations
    -- A = B
    ResultEQ <= (0 => '1', OTHERS => '0') WHEN A = B ELSE
        TempZero;

    -- A != B
    ResultNEQ <= (0 => '1', OTHERS => '0') WHEN A /= B ELSE
        TempZero;

    -- A < B
    ResultL <= (0 => '1', OTHERS => '0') WHEN TempSA < TempSB ELSE
        TempZero;

    -- Un A < B
    ResultUnL <= (0 => '1', OTHERS => '0') WHEN TempUA < TempUB ELSE
        TempZero;

    -- A <= B
    ResultLE <= (0 => '1', OTHERS => '0') WHEN TempSA <= TempSB ELSE
        TempZero;

    -- Un A <= B
    ResultUnLE <= (0 => '1', OTHERS => '0') WHEN TempUA <= TempUB ELSE
        TempZero;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Shift and Rotating operations
    -- SLL
    ResultSLL <= STD_LOGIC_VECTOR(SHIFT_LEFT(TempUA, to_integer(unsigned(B(5 DOWNTO 0)))));

    -- SRL
    ResultSRL <= STD_LOGIC_VECTOR(SHIFT_RIGHT(TempUA, to_integer(unsigned(B(5 DOWNTO 0)))));

    -- SRA
    ResultSRA <= STD_LOGIC_VECTOR(SHIFT_RIGHT(TempSA, to_integer(unsigned(B(5 DOWNTO 0)))));

    -- ROL
    ResultROL <= STD_LOGIC_VECTOR(ROTATE_LEFT(TempUA, to_integer(unsigned(B(5 DOWNTO 0)))));

    -- ROR
    ResultROR <= STD_LOGIC_VECTOR(ROTATE_RIGHT(TempUA, to_integer(unsigned(B(5 DOWNTO 0)))));

    -- SLLW
    TempSLLW <= STD_LOGIC_VECTOR(SHIFT_LEFT(TempUAL, to_integer(unsigned(B(4 DOWNTO 0)))));
    ResultSLLW <= (63 DOWNTO 32 => TempSLLW(31)) & TempSLLW;

    -- SRLW
    TempSRLW <= STD_LOGIC_VECTOR(SHIFT_RIGHT(TempUAL, to_integer(unsigned(B(4 DOWNTO 0)))));
    ResultSRLW <= (63 DOWNTO 32 => TempSRLW(31)) & TempSRLW;

    -- SRAW
    TempSRAW <= STD_LOGIC_VECTOR(SHIFT_RIGHT(TempSAL, to_integer(unsigned(B(4 DOWNTO 0)))));
    ResultSRAW <= (63 DOWNTO 32 => TempSRAW(31)) & TempSRAW;

    -- ROLW
    TempROLW <= STD_LOGIC_VECTOR(ROTATE_LEFT(TempUAL, to_integer(unsigned(B(4 DOWNTO 0)))));
    ResultROLW <= (63 DOWNTO 32 => TempROLW(31)) & TempROLW;

    -- RORW
    TempRORW <= STD_LOGIC_VECTOR(ROTATE_RIGHT(TempUAL, to_integer(unsigned(B(4 DOWNTO 0)))));
    ResultRORW <= (63 DOWNTO 32 => TempRORW(31)) & TempRORW;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Custom Compare Operations
    -- MIN
    ResultMIN <= A WHEN TempSA < TempSB ELSE
        B;

    -- MINU
    ResultMINU <= A WHEN TempUA < TempUB ELSE
        B;

    -- MAX
    ResultMAX <= A WHEN TempSA < TempSB ELSE
        B;

    -- MAXU
    ResultMAXU <= A WHEN TempUA < TempUB ELSE
        B;
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Custom Bit Count Operations
    SIGNAL ResultCLZ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultCTZ : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultCPOP : STD_LOGIC_VECTOR(63 DOWNTO 0);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Custom Shift and Add Operations
    -- SH1ADD
    TempSH1ADD <= SHIFT_LEFT((TempSA(63) & TempSA), 1) + (TempSB(63) & TempSB);
    ResultSH1ADD <= STD_LOGIC_VECTOR(TempSH1ADD);

    -- SH2ADD
    TempSH2ADD <= SHIFT_LEFT((TempSA(63) & TempSA), 2) + (TempSB(63) & TempSB);
    ResultSH2ADD <= STD_LOGIC_VECTOR(TempSH2ADD);

    -- SH3ADD
    TempSH3ADD <= SHIFT_LEFT((TempSA(63) & TempSA), 3) + (TempSB(63) & TempSB);
    ResultSH3ADD <= STD_LOGIC_VECTOR(TempSH3ADD);

    -- SH4ADD
    TempSH4ADD <= SHIFT_LEFT((TempSA(63) & TempSA), 4) + (TempSB(63) & TempSB);
    ResultSH4ADD <= STD_LOGIC_VECTOR(TempSH4ADD);

    -- SH8ADD
    TempSH8ADD <= SHIFT_LEFT((TempSA(63) & TempSA), 8) + (TempSB(63) & TempSB);
    ResultSH8ADD <= STD_LOGIC_VECTOR(TempSH8ADD);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Custom Bit Manipulation Operations
    SIGNAL ResultBSET : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBCLR : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBINV : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL ResultBEXT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Other Custom Operations
    -- REV8
    ResultREV8 <= A(7 DOWNTO 0) & A(15 DOWNTO 8) & A(23 DOWNTO 16) & A(31 DOWNTO 24)
        & A(39 DOWNTO 32) & A(47 DOWNTO 40) & A(55 DOWNTO 48) & A(63 DOWNTO 56);

    SIGNAL ResultORCB : STD_LOGIC_VECTOR(63 DOWNTO 0);
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Enable and Select
    Enable <= STD_LOGIC_VECTOR(shift_left(to_unsigned(1, 64), to_integer(unsigned(S))));
    ------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------
    -- Multiplexing
    TempResult <=
        -- Arithmetic operations
        (ResultADD AND (63 DOWNTO 0 => Enable(0)))
        OR (ResultSUB AND (63 DOWNTO 0 => Enable(1)))
        OR (ResultADDW AND (63 DOWNTO 0 => Enable(2)))
        OR (ResultSUBW AND (63 DOWNTO 0 => Enable(3)))
        OR (ResultABS AND (63 DOWNTO 0 => Enable(4)))
        OR (ResultABSW AND (63 DOWNTO 0 => Enable(5)))
        OR (ResultMUL AND (63 DOWNTO 0 => Enable(6)))
        OR (ResultMULH AND (63 DOWNTO 0 => Enable(7)))
        OR (ResultMULHSU AND (63 DOWNTO 0 => Enable(8)))
        OR (ResultMULHU AND (63 DOWNTO 0 => Enable(9)))
        OR (ResultMULW AND (63 DOWNTO 0 => Enable(10)))
        OR (ResultDIV AND (63 DOWNTO 0 => Enable(11)))
        OR (ResultDIVU AND (63 DOWNTO 0 => Enable(12)))
        OR (ResultDIVW AND (63 DOWNTO 0 => Enable(13)))
        OR (ResultDIVUW AND (63 DOWNTO 0 => Enable(14)))
        OR (ResultREM AND (63 DOWNTO 0 => Enable(15)))
        OR (ResultREMU AND (63 DOWNTO 0 => Enable(16)))
        OR (ResultREMW AND (63 DOWNTO 0 => Enable(17)))
        OR (ResultREMUW AND (63 DOWNTO 0 => Enable(18)))
        -- Logic operations
        OR (A AND (63 DOWNTO 0 => Enable(19)))
        OR (ResultNOT AND (63 DOWNTO 0 => Enable(20)))
        OR (ResultAND AND (63 DOWNTO 0 => Enable(21)))
        OR (ResultOR AND (63 DOWNTO 0 => Enable(22)))
        OR (ResultXOR AND (63 DOWNTO 0 => Enable(23)))
        OR (ResultNAND AND (63 DOWNTO 0 => Enable(24)))
        OR (ResultNOR AND (63 DOWNTO 0 => Enable(25)))
        OR (ResultXNOR AND (63 DOWNTO 0 => Enable(26)))
        -- Compare operations
        OR (ResultEQ AND (63 DOWNTO 0 => Enable(27)))
        OR (ResultL AND (63 DOWNTO 0 => Enable(28)))
        OR (ResultUnL AND (63 DOWNTO 0 => Enable(29)))
        OR (ResultLE AND (63 DOWNTO 0 => Enable(30)))
        OR (ResultUnLE AND (63 DOWNTO 0 => Enable(31)))
        -- Shift and Rotating operations
        OR (ResultSLL AND (63 DOWNTO 0 => Enable(32)))
        OR (ResultSRL AND (63 DOWNTO 0 => Enable(33)))
        OR (ResultSRA AND (63 DOWNTO 0 => Enable(34)))
        OR (ResultROL AND (63 DOWNTO 0 => Enable(35)))
        OR (ResultROR AND (63 DOWNTO 0 => Enable(36)))
        OR (ResultSLLW AND (63 DOWNTO 0 => Enable(37)))
        OR (ResultSRLW AND (63 DOWNTO 0 => Enable(38)))
        OR (ResultSRAW AND (63 DOWNTO 0 => Enable(39)))
        OR (ResultROLW AND (63 DOWNTO 0 => Enable(40)))
        OR (ResultRORW AND (63 DOWNTO 0 => Enable(41)));

    Cout <=
        (CoutADD AND Enable(36))
        OR (CoutSUB AND Enable(37))
        OR (CoutADDW AND Enable(38))
        OR (CoutSUBW AND Enable(39));

    Overflow <=
        (OverflowADD AND Enable(36))
        OR (OverflowSUB AND Enable(37))
        OR (OverflowADDW AND Enable(38))
        OR (OverflowSUBW AND Enable(39));

    Result <= TempResult;

    Zero <= '1' WHEN TempResult = TempZero ELSE
        '0';

END struct;