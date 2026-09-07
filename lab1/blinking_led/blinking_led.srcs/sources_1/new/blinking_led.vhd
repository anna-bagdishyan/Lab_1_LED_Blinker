----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2026 03:43:32 PM
-- Design Name: 
-- Module Name: blinking_led - Behavioral
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

entity blinking_led is
    generic (
    CLK_CYCLES_PER_TOGGLE : integer := 62500000
    );
    port ( 
        sys_clk : in std_logic;
        rst : in std_logic;
        led_en : in std_logic; 
        
        led_out : out std_logic
    );
end blinking_led;

architecture Behavioral of blinking_led is
    signal counter : integer := 0;
    signal led_out_int : std_logic := '0';
    
begin
    led_out <= led_out_int;
    counter_process : process(sys_clk) is
    begin
        if rising_edge(sys_clk) then
            if rst = '1' or led_en = '0' then
                led_out_int <= '0';
                counter <= 0;
                
            elsif counter = CLK_CYCLES_PER_TOGGLE - 1 then
                led_out_int <= not led_out_int; -- internal led_out
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

end Behavioral;
