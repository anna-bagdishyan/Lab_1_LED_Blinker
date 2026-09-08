----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2026 04:38:21 PM
-- Design Name: 
-- Module Name: rgb_led_top - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rgb_led_top is
    generic (
        CLK_CYCLES_PER_TOGGLE : integer := 62500000
    );
    port ( 
        sys_clk : in std_logic;
        rst : in std_logic;
        sw : in std_logic_vector(2 downto 0); 
        
        rgb_out : out std_logic_vector(2 downto 0)
    );
end rgb_led_top;

architecture Behavioral of rgb_led_top is

    component blinking_led
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
        
        signal led_en : std_logic;
        signal led_outb : std_logic; -- must blink once every second (so, on)
begin

led_en <= '1' when sw = "001" or sw = "010" or sw = "100" else '0'; 

-----------------------------------------------------------------------------
  -- blinking_led
-----------------------------------------------------------------------------
        blink_led : blinking_led
        generic map (
            CLK_CYCLES_PER_TOGGLE => CLK_CYCLES_PER_TOGGLE
        )
        port map (
           sys_clk => sys_clk,
           rst => rst,
           led_en    => led_en,
           led_out  => led_outb
          );

rgb_out <= "001" when sw = "001" and led_outb = '1' else
           "010" when sw = "010" and led_outb = '1' else
           "100" when sw = "100" and led_outb = '1' else "000";
           
end Behavioral;
