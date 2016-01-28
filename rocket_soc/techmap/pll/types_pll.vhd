-----------------------------------------------------------------------------
--! @file
--! @copyright Copyright 2015 GNSS Sensor Ltd. All right reserved.
--! @author    Sergey Khabarov - sergeykhbr@gmail.com
--! @brief     Components declaration of the types_pll package.
------------------------------------------------------------------------------

--! Standard library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--! Target names declaration
library techmap;
use techmap.gencomp.all;

--! @brief Declaration of 'virtual' PLL components
package types_pll is

  --! @brief   Declaration of the "virtual" PLL component.
  --! @details This module instantiates the certain PLL implementation
  --!          depending generic argument.
  --! @param[in] tech Generic PLL implementation selector
  --! @param[in] i_reset Reset value. Active high.
  --! @param[in] i_int_clkrf ADC source select:
  --!            0 = External ADC clock (Real RF front-end)
  --!            1 = Disable external ADC/enable internal ADC simulation.
  --! @param[in] i_clkp Differential clock input positive
  --! @param[in] i_clkn Differential clock input negative
  --! @param[in] i_clk_adc External ADC clock
  --! @param[out] o_clk_bus System Bus clock 100MHz/40MHz (Virtex6/Spartan6)
  --! @param[out] o_clk_adc ADC simulation clock = 26MHz (default).
  --! @param[out] o_locked PLL locked status.
  component SysPLL_tech is
    generic(
      tech    : integer range 0 to NTECH := 0
    );
    port (
    i_reset           : in     std_logic;
    i_int_clkrf       : in     std_logic;
    i_clkp            : in     std_logic;
    i_clkn            : in     std_logic;
    i_clk_adc         : in     std_logic;
    o_clk_bus         : out    std_logic;
    o_clk_adc         : out    std_logic;
    o_locked          : out    std_logic);
  end component;

  --! @name    Technology specific PLL components.
  --! @param[in] CLK_IN1_P Differential clock input positive
  --! @param[in] CLK_IN1_N Differential clock input negative
  --! @param[out] CLK_OUT1 PLL clock output.
  --! @param[in] RESET Reset value. Active high.
  --! @param[out] LOCKED PLL locked status.
  --! @{

  --! @brief   Declaration of the PLL component used for RTL simulation.
  component SysPLL_inferred is
  port (
    CLK_IN1_P   : in     std_logic;
    CLK_IN1_N   : in     std_logic;
    CLK_OUT1    : out    std_logic;
    RESET       : in     std_logic;
    LOCKED      : out    std_logic );
  end component;

  --! @brief   Declaration of the PLL component used for ML605 board.
  --! @details This module was generated by Xilinx CoreGen for Virtex6 FPGA.
  component SysPLL_v6 is 
  port (
    CLK_IN1_P   : in     std_logic;
    CLK_IN1_N   : in     std_logic;
    CLK_OUT1	: out std_logic;
    RESET	: in std_logic;
    LOCKED	: out std_logic );
  end component;

  --! @brief   Declaration of the PLL component used for KC705 board.
  --! @details This module was generated by Xilinx CoreGen for Kintex7 FPGA.
  component SysPLL_k7 is
  port (
    CLK_IN1_P   : in     std_logic;
    CLK_IN1_N   : in     std_logic;
    CLK_OUT1  : out    std_logic;
    RESET     : in     std_logic;
    LOCKED    : out    std_logic );
  end component;

  --! @brief   Declaration of the PLL component used Mikron 180nm ASIC.
  --! @details This module is made as the netlist generated by fabric.
  component SysPLL_micron180 is
  port (
    CLK_IN1_P   : in     std_logic;
    CLK_IN1_N   : in     std_logic;
    CLK_OUT1    : out    std_logic;
    RESET       : in     std_logic;
    LOCKED      : out    std_logic );
  end component;
  --! @}
end;
