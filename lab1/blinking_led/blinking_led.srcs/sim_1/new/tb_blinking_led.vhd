----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2026 04:00:09 PM
-- Design Name: 
-- Module Name: tb_blinking_led - Behavioral
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

  component blinking_led is
    generic (
    CLK_CYCLES_PER_TOGGLE : integer := 62500000
    );
    port ( 
        sys_clk : in std_logic;
        rst : in std_logic;
        led_en : in std_logic; 
        
        led_out : out std_logic
    );
  end component;

  signal sys_clk: std_logic;
  signal rst: std_logic;
  signal led_en: std_logic;
  
  signal led_out: std_logic;

  constant CLK_PERIOD : time := 8 ns; -- 125 MHz

begin

  ------------------------------------------------------------------------------
  -- Device Under Test
  ------------------------------------------------------------------------------
DUT : blinking_led
    generic map (
        CLK_CYCLES_PER_TOGGLE => 10) -- toggles every 10 clock cycles
    port map(
      sys_clk => sys_clk,
      rst => rst,
      led_en => led_en,
      led_out => led_out
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
    led_en <= '0';
    wait for 5*CLK_PERIOD; -- waiting for first 5 clock cycles
    
    if led_out /= '0' then
      report "FAILED led_out is not 0 during reset";
      finish;
    end if;
    
    -- Test Case 2 - Disabled Output
    rst <= '0';
    led_en <= '0';
    
    wait for 5*CLK_PERIOD; -- waiting for first 5 clock cycles
    
    if led_out /= '0' then
      report "FAILED led_out is not 0 while output is disabled";
      finish;
    end if;

    -- Test Case 3 - LED Toggling
    led_en <= '1';
    
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
    
    if led_out /= '1' then
      report "FAILED led_out is not 1 after 10 rising edges of sys_clk";
      finish;
    end if;
    
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
    
    if led_out /= '0' then
      report "FAILED led_out did not toggle to 0";
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
