-- -------------------------------------------------------------
-- 
-- File Name: ..\hdl\hdlconvert_tb\hdlconvert_demo_tb.vhd
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1
-- Target subsystem base rate: 1
-- 
-- Copyright 2016 Viasat.
-- Author: mike babst <mikebabst@gmail.com>
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: hdlconvert_demo_tb
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
LIBRARY work;
USE work.hdlconvert_demo_pkg.ALL;
USE work.hdlconvert_demo_tb_pkg.ALL;

ENTITY hdlconvert_demo_tb IS
END hdlconvert_demo_tb;


ARCHITECTURE rtl OF hdlconvert_demo_tb IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT hdlconvert_demo
    PORT( din                             :   IN    std_logic_vector(7 DOWNTO 0);  -- sfix8_En4
          din_vec                         :   IN    vector_of_std_logic_vector8(0 TO 1);  -- sfix8_En4 [2]
          bestrange_d                     :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6_En2
          bestprecision_d                 :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6_En4
          brfloor_d                       :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6_En2
          brcvg_d                         :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6_En2
          nosat_d                         :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6_En4
          dout_vec                        :   OUT   vector_of_std_logic_vector6(0 TO 1)  -- sfix6_En4 [2]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : hdlconvert_demo
    USE ENTITY work.hdlconvert_demo(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL dout_vec_done                    : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL dout_vec_done_enb                : std_logic;  -- ufix1
  SIGNAL bestrange_d_addr                 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL dout_vec_lastAddr                : std_logic;  -- ufix1
  SIGNAL resetn                           : std_logic;
  SIGNAL check6_done                      : std_logic;  -- ufix1
  SIGNAL nosat_d_done                     : std_logic;  -- ufix1
  SIGNAL nosat_d_done_enb                 : std_logic;  -- ufix1
  SIGNAL nosat_d_lastAddr                 : std_logic;  -- ufix1
  SIGNAL check5_done                      : std_logic;  -- ufix1
  SIGNAL brcvg_d_done                     : std_logic;  -- ufix1
  SIGNAL brcvg_d_done_enb                 : std_logic;  -- ufix1
  SIGNAL brcvg_d_lastAddr                 : std_logic;  -- ufix1
  SIGNAL check4_done                      : std_logic;  -- ufix1
  SIGNAL brfloor_d_done                   : std_logic;  -- ufix1
  SIGNAL brfloor_d_done_enb               : std_logic;  -- ufix1
  SIGNAL brfloor_d_lastAddr               : std_logic;  -- ufix1
  SIGNAL check3_done                      : std_logic;  -- ufix1
  SIGNAL bestprecision_d_done             : std_logic;  -- ufix1
  SIGNAL bestprecision_d_done_enb         : std_logic;  -- ufix1
  SIGNAL bestprecision_d_lastAddr         : std_logic;  -- ufix1
  SIGNAL check2_done                      : std_logic;  -- ufix1
  SIGNAL bestrange_d_done                 : std_logic;  -- ufix1
  SIGNAL bestrange_d_done_enb             : std_logic;  -- ufix1
  SIGNAL bestrange_d_active               : std_logic;  -- ufix1
  SIGNAL snkDone                          : std_logic;
  SIGNAL snkDonen                         : std_logic;
  SIGNAL tb_enb                           : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL bestrange_d_enb                  : std_logic;  -- ufix1
  SIGNAL bestrange_d_lastAddr             : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL Data_Type_Conversion_out1_addr   : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Data_Type_Conversion_out1_active : std_logic;  -- ufix1
  SIGNAL Data_Type_Conversion_out1_enb    : std_logic;  -- ufix1
  SIGNAL Data_Type_Conversion_out1_addr_delay_1 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL rawData_din                      : signed(7 DOWNTO 0);  -- sfix8_En4
  SIGNAL holdData_din                     : signed(7 DOWNTO 0);  -- sfix8_En4
  SIGNAL Mux_out1_addr_delay_1            : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL rawData_din_vec                  : vector_of_signed8(0 TO 1);  -- sfix8_En4 [2]
  SIGNAL holdData_din_vec                 : vector_of_signed8(0 TO 1);  -- sfix8_En4 [2]
  SIGNAL din_offset                       : signed(7 DOWNTO 0);  -- sfix8_En4
  SIGNAL din                              : signed(7 DOWNTO 0);  -- sfix8_En4
  SIGNAL din_1                            : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL din_vec_offset                   : vector_of_signed8(0 TO 1);  -- sfix8_En4 [2]
  SIGNAL din_vec                          : vector_of_signed8(0 TO 1);  -- sfix8_En4 [2]
  SIGNAL din_vec_1                        : vector_of_std_logic_vector8(0 TO 1);  -- ufix8 [2]
  SIGNAL bestrange_d                      : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL bestprecision_d                  : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL brfloor_d                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL brcvg_d                          : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL nosat_d                          : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL dout_vec                         : vector_of_std_logic_vector6(0 TO 1);  -- ufix6 [2]
  SIGNAL bestrange_d_signed               : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL bestrange_d_addr_delay_1         : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL bestrange_d_expected             : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL bestrange_d_ref                  : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL bestrange_d_testFailure          : std_logic;  -- ufix1
  SIGNAL bestprecision_d_signed           : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL bestprecision_d_addr_delay_1     : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL bestprecision_d_expected         : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL bestprecision_d_ref              : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL bestprecision_d_testFailure      : std_logic;  -- ufix1
  SIGNAL brfloor_d_signed                 : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brfloor_d_addr_delay_1           : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL brfloor_d_expected               : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brfloor_d_ref                    : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brfloor_d_testFailure            : std_logic;  -- ufix1
  SIGNAL brcvg_d_signed                   : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brcvg_d_addr_delay_1             : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL brcvg_d_expected                 : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brcvg_d_ref                      : signed(5 DOWNTO 0);  -- sfix6_En2
  SIGNAL brcvg_d_testFailure              : std_logic;  -- ufix1
  SIGNAL nosat_d_signed                   : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL nosat_d_addr_delay_1             : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL nosat_d_expected                 : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL nosat_d_ref                      : signed(5 DOWNTO 0);  -- sfix6_En4
  SIGNAL nosat_d_testFailure              : std_logic;  -- ufix1
  SIGNAL dout_vec_signed                  : vector_of_signed6(0 TO 1);  -- sfix6_En4 [2]
  SIGNAL dout_vec_addr_delay_1            : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL dout_vec_expected                : vector_of_signed6(0 TO 1);  -- sfix6_En4 [2]
  SIGNAL dout_vec_ref                     : vector_of_signed6(0 TO 1);  -- sfix6_En4 [2]
  SIGNAL dout_vec_testFailure             : std_logic;  -- ufix1
  SIGNAL testFailure                      : std_logic;  -- ufix1

BEGIN
  u_hdlconvert_demo : hdlconvert_demo
    PORT MAP( din => din_1,  -- sfix8_En4
              din_vec => din_vec_1,  -- sfix8_En4 [2]
              bestrange_d => bestrange_d,  -- sfix6_En2
              bestprecision_d => bestprecision_d,  -- sfix6_En4
              brfloor_d => brfloor_d,  -- sfix6_En2
              brcvg_d => brcvg_d,  -- sfix6_En2
              nosat_d => nosat_d,  -- sfix6_En4
              dout_vec => dout_vec  -- sfix6_En4 [2]
              );

  dout_vec_done_enb <= dout_vec_done AND rdEnb;

  
  dout_vec_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  dout_vec_done <= dout_vec_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_6_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check6_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF dout_vec_done_enb = '1' THEN
        check6_done <= dout_vec_done;
      END IF;
    END IF;
  END PROCESS checkDone_6_process;

  nosat_d_done_enb <= nosat_d_done AND rdEnb;

  
  nosat_d_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  nosat_d_done <= nosat_d_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_5_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check5_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF nosat_d_done_enb = '1' THEN
        check5_done <= nosat_d_done;
      END IF;
    END IF;
  END PROCESS checkDone_5_process;

  brcvg_d_done_enb <= brcvg_d_done AND rdEnb;

  
  brcvg_d_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  brcvg_d_done <= brcvg_d_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_4_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check4_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF brcvg_d_done_enb = '1' THEN
        check4_done <= brcvg_d_done;
      END IF;
    END IF;
  END PROCESS checkDone_4_process;

  brfloor_d_done_enb <= brfloor_d_done AND rdEnb;

  
  brfloor_d_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  brfloor_d_done <= brfloor_d_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_3_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check3_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF brfloor_d_done_enb = '1' THEN
        check3_done <= brfloor_d_done;
      END IF;
    END IF;
  END PROCESS checkDone_3_process;

  bestprecision_d_done_enb <= bestprecision_d_done AND rdEnb;

  
  bestprecision_d_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  bestprecision_d_done <= bestprecision_d_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check2_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF bestprecision_d_done_enb = '1' THEN
        check2_done <= bestprecision_d_done;
      END IF;
    END IF;
  END PROCESS checkDone_2_process;

  bestrange_d_done_enb <= bestrange_d_done AND rdEnb;

  
  bestrange_d_active <= '1' WHEN bestrange_d_addr /= to_unsigned(16#300#, 10) ELSE
      '0';

  enb <= rdEnb AFTER 2 ns;

  snkDonen <=  NOT snkDone;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF snkDone = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  
  rdEnb <= tb_enb WHEN snkDone = '0' ELSE
      '0';

  ce_out <= enb AND (rdEnb AND tb_enb);

  bestrange_d_enb <= ce_out AND bestrange_d_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 768
  c_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      bestrange_d_addr <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF bestrange_d_enb = '1' THEN
        IF bestrange_d_addr = to_unsigned(16#300#, 10) THEN 
          bestrange_d_addr <= to_unsigned(16#000#, 10);
        ELSE 
          bestrange_d_addr <= bestrange_d_addr + to_unsigned(16#001#, 10);
        END IF;
      END IF;
    END IF;
  END PROCESS c_5_process;


  
  bestrange_d_lastAddr <= '1' WHEN bestrange_d_addr >= to_unsigned(16#300#, 10) ELSE
      '0';

  bestrange_d_done <= bestrange_d_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF bestrange_d_done_enb = '1' THEN
        check1_done <= bestrange_d_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  snkDone <= check6_done AND (check5_done AND (check4_done AND (check3_done AND (check1_done AND check2_done))));

  
  Data_Type_Conversion_out1_active <= '1' WHEN Data_Type_Conversion_out1_addr /= to_unsigned(16#300#, 10) ELSE
      '0';

  Data_Type_Conversion_out1_enb <= Data_Type_Conversion_out1_active AND (rdEnb AND tb_enb);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 768
  DataTypeConversion_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Data_Type_Conversion_out1_addr <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF Data_Type_Conversion_out1_enb = '1' THEN
        IF Data_Type_Conversion_out1_addr = to_unsigned(16#300#, 10) THEN 
          Data_Type_Conversion_out1_addr <= to_unsigned(16#000#, 10);
        ELSE 
          Data_Type_Conversion_out1_addr <= Data_Type_Conversion_out1_addr + to_unsigned(16#001#, 10);
        END IF;
      END IF;
    END IF;
  END PROCESS DataTypeConversion_process;


  Data_Type_Conversion_out1_addr_delay_1 <= Data_Type_Conversion_out1_addr AFTER 1 ns;

  -- Data source for din
  din_fileread: PROCESS (Data_Type_Conversion_out1_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "din.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_din <= signed(read_data(7 DOWNTO 0));
  END PROCESS din_fileread;

  -- holdData reg for Data_Type_Conversion_out1
  stimuli_Data_Type_Conversion_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_din <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_din <= rawData_din;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion_out1_process;

  Mux_out1_addr_delay_1 <= Data_Type_Conversion_out1_addr AFTER 1 ns;

  -- Data source for din_vec
  din_vec_fileread: PROCESS (Mux_out1_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "din_vec.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: vector_of_std_logic_vector8(0 TO 1);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data(0));
      HREAD(l, read_data(1));
    END IF;
    rawData_din_vec <= (signed(read_data(0)(7 DOWNTO 0)), signed(read_data(1)(7 DOWNTO 0)));
  END PROCESS din_vec_fileread;

  -- holdData reg for Mux_out1
  stimuli_Mux_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_din_vec <= (OTHERS => (OTHERS => 'X'));
    ELSIF clk'event AND clk = '1' THEN
      holdData_din_vec <= rawData_din_vec;
    END IF;
  END PROCESS stimuli_Mux_out1_process;

  stimuli_Data_Type_Conversion_out1_1: PROCESS (rawData_din, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      din_offset <= holdData_din;
    ELSE
      din_offset <= rawData_din;
    END IF;
  END PROCESS stimuli_Data_Type_Conversion_out1_1;

  din <= din_offset AFTER 2 ns;

  din_1 <= std_logic_vector(din);

  stimuli_Mux_out1_1: PROCESS (rawData_din_vec, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      din_vec_offset <= holdData_din_vec;
    ELSE
      din_vec_offset <= rawData_din_vec;
    END IF;
  END PROCESS stimuli_Mux_out1_1;

  din_vec <= din_vec_offset AFTER 2 ns;

  outputgen1: FOR k IN 0 TO 1 GENERATE
    din_vec_1(k) <= std_logic_vector(din_vec(k));
  END GENERATE;

  bestrange_d_signed <= signed(bestrange_d);

  bestrange_d_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for bestrange_d_expected
  bestrange_d_expected_fileread: PROCESS (bestrange_d_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "bestrange_d_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    bestrange_d_expected <= signed(read_data(5 DOWNTO 0));
  END PROCESS bestrange_d_expected_fileread;

  bestrange_d_ref <= bestrange_d_expected;

  bestrange_d_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      bestrange_d_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND bestrange_d_signed /= bestrange_d_ref THEN
        bestrange_d_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in bestrange_d_signed: Expected " & to_hex(bestrange_d_ref) & (" Actual " & to_hex(bestrange_d_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS bestrange_d_signed_checker;

  bestprecision_d_signed <= signed(bestprecision_d);

  bestprecision_d_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for bestprecision_d_expected
  bestprecision_d_expected_fileread: PROCESS (bestprecision_d_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "bestprecision_d_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    bestprecision_d_expected <= signed(read_data(5 DOWNTO 0));
  END PROCESS bestprecision_d_expected_fileread;

  bestprecision_d_ref <= bestprecision_d_expected;

  bestprecision_d_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      bestprecision_d_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND bestprecision_d_signed /= bestprecision_d_ref THEN
        bestprecision_d_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in bestprecision_d_signed: Expected " & to_hex(bestprecision_d_ref) & (" Actual " & to_hex(bestprecision_d_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS bestprecision_d_signed_checker;

  brfloor_d_signed <= signed(brfloor_d);

  brfloor_d_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for brfloor_d_expected
  brfloor_d_expected_fileread: PROCESS (brfloor_d_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "brfloor_d_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    brfloor_d_expected <= signed(read_data(5 DOWNTO 0));
  END PROCESS brfloor_d_expected_fileread;

  brfloor_d_ref <= brfloor_d_expected;

  brfloor_d_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      brfloor_d_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND brfloor_d_signed /= brfloor_d_ref THEN
        brfloor_d_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in brfloor_d_signed: Expected " & to_hex(brfloor_d_ref) & (" Actual " & to_hex(brfloor_d_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS brfloor_d_signed_checker;

  brcvg_d_signed <= signed(brcvg_d);

  brcvg_d_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for brcvg_d_expected
  brcvg_d_expected_fileread: PROCESS (brcvg_d_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "brcvg_d_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    brcvg_d_expected <= signed(read_data(5 DOWNTO 0));
  END PROCESS brcvg_d_expected_fileread;

  brcvg_d_ref <= brcvg_d_expected;

  brcvg_d_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      brcvg_d_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND brcvg_d_signed /= brcvg_d_ref THEN
        brcvg_d_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in brcvg_d_signed: Expected " & to_hex(brcvg_d_ref) & (" Actual " & to_hex(brcvg_d_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS brcvg_d_signed_checker;

  nosat_d_signed <= signed(nosat_d);

  nosat_d_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for nosat_d_expected
  nosat_d_expected_fileread: PROCESS (nosat_d_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "nosat_d_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    nosat_d_expected <= signed(read_data(5 DOWNTO 0));
  END PROCESS nosat_d_expected_fileread;

  nosat_d_ref <= nosat_d_expected;

  nosat_d_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      nosat_d_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND nosat_d_signed /= nosat_d_ref THEN
        nosat_d_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in nosat_d_signed: Expected " & to_hex(nosat_d_ref) & (" Actual " & to_hex(nosat_d_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS nosat_d_signed_checker;

  outputgen: FOR k IN 0 TO 1 GENERATE
    dout_vec_signed(k) <= signed(dout_vec(k));
  END GENERATE;

  dout_vec_addr_delay_1 <= bestrange_d_addr AFTER 1 ns;

  -- Data source for dout_vec_expected
  dout_vec_expected_fileread: PROCESS (dout_vec_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "dout_vec_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: vector_of_std_logic_vector8(0 TO 1);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data(0));
      HREAD(l, read_data(1));
    END IF;
    dout_vec_expected <= (signed(read_data(0)(5 DOWNTO 0)), signed(read_data(1)(5 DOWNTO 0)));
  END PROCESS dout_vec_expected_fileread;

  dout_vec_ref <= dout_vec_expected;

  dout_vec_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dout_vec_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND dout_vec_signed /= dout_vec_ref THEN
        dout_vec_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in dout_vec_signed: Expected " & to_hex(dout_vec_ref) & (" Actual " & to_hex(dout_vec_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS dout_vec_signed_checker;

  testFailure <= dout_vec_testFailure OR (nosat_d_testFailure OR (brcvg_d_testFailure OR (brfloor_d_testFailure OR (bestrange_d_testFailure OR bestprecision_d_testFailure))));

  completed_msg: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF snkDone = '1' THEN
        IF testFailure = '0' THEN
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (PASSED)**************"
            SEVERITY NOTE;
        ELSE
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (FAILED)**************"
            SEVERITY NOTE;
        END IF;
      END IF;
    END IF;
  END PROCESS completed_msg;

END rtl;

