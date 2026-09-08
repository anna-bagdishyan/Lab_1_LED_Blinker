----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2026 04:53:11 PM
-- Design Name: 
-- Module Name: tb_rgb_led_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use std.env.finish;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

  component rgb_led_top is
  generic (
    CLK_CYCLES_PER_TOGGLE : integer := 62500000
    );
    port ( 
        sys_clk : in std_logic;
        rst : in std_logic;
        sw : in std_logic_vector(2 downto 0); 
        
        rgb_out : out std_logic_vector(2 downto 0)
    );
  end component;

  signal sys_clk: std_logic;
  signal rst: std_logic;
  signal sw: std_logic_vector(2 downto 0);
  
  signal rgb_out : std_logic_vector(2 downto 0);

  constant CLK_PERIOD : time := 8 ns; -- 125 MHz

begin

  ------------------------------------------------------------------------------
  -- Device Under Test
  ------------------------------------------------------------------------------
DUT : rgb_led_top
    generic map (
        CLK_CYCLES_PER_TOGGLE => 10) 
    port map(
      sys_clk => sys_clk,
      rst => rst,
      sw => sw,
      rgb_out => rgb_out
    );
    
  ------------------------------------------------------------------------------
  -- Clock Generation
  ------------------------------------------------------------------------------
  clk_process : process
  begin
    sys_clk <= '0';
    wait for CLK_PERIOD/2;
    sys_clk <= '1';
    wait for CLK_PERIOD/2;
  end process;

  ------------------------------------------------------------------------------
  -- Test Case
  ------------------------------------------------------------------------------
  test_case : process
  begin

    -- Test Case 1 - Reset Behavior
    rst <= '1';
    sw <= "001";
    wait for 5*CLK_PERIOD; -- waiting for first 5 clock cycles
    
    if rgb_out /= "000" then
      report "FAILED rgb_out is not 000 during reset";
      finish;
    end if;
    
    rst <= '0';
    wait until rising_edge(sys_clk);
    wait for 1 ns;
    
    -- Test Case 2 - Multiple Switches
    sw <= "011";
    wait for 5*CLK_PERIOD; -- waiting for first 5 clock cycles
    
    if rgb_out /= "000" then
      report "FAILED rgb_out is not 000 when multiple switches are pressed";
      finish;
    end if;

    -- Test Case 3 - RED LED
    sw <= "001";
    
    wait until rising_edge(sys_clk); -- waiting for 10 rising edges of the clock
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait for 1 ns;    
    
    if rgb_out /= "001" then
      report "FAILED rgb_out is not red when sw = 001";
      finish;
    end if;
    
    sw <= "000";
    wait until rising_edge(sys_clk);
    wait for 1 ns;
    
    -- Test Case 4 - Green LED
    sw <= "010";
    
    wait until rising_edge(sys_clk); -- waiting for 10 rising edges of the clock
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait for 1 ns;    
    
    if rgb_out /= "010" then
      report "FAILED rgb_out is not green when sw = 010";
      finish;
    end if;
    
    
    sw <= "000";
    wait until rising_edge(sys_clk);
    wait for 1 ns;
    
    -- Test Case 5 - Blue LED
    sw <= "100";
    
    wait until rising_edge(sys_clk); -- waiting for 10 rising edges of the clock
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait until rising_edge(sys_clk);
    wait for 1 ns;    
    
    if rgb_out /= "100" then
      report "FAILED rgb_out is not blue when sw = 100";
      finish;
    end if;

    report "TEST PASSED";
    finish;

    wait;
  end process;

  ------------------------------------------------------------------------------
  -- Timeout
  ------------------------------------------------------------------------------
  timeout : process
  begin
    wait for 1 us;
    report "TEST FAILED: TIMEOUT";
    finish;
  end process;

end Behavioral;