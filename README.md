# Lab 1 LED Blinker

# Overview

This lab involved designing and implementing an LED blinker in VHDL for the Zybo Z7 board. The blinking_led module was first created to toggle an LED using the 125 MHz system clock. The design was then modified and extended for Task 1 to control the on-board RGB LED using the switches to select between the red, green, and blue LEDs.

# Design Summary

The blinking_led module uses the signals counter and led_out_int, which were declared in the architecture. led_out_int was used as an intermediate signal for the LED output. A process was created that updates on every rising edge of sys_clk. When the counter reaches CLK_CYCLES_PER_TOGGLE - 1, the counter is reset to 0 and the LED output toggles. As specified by the design requirements, the counter and led_out_int are cleared to 0 when the reset is triggered or when led_en is not enabled. With the 125 MHz system clock, the LED output is toggled every 0.5 seconds, which results in the LED blinking every second.

For Task 1, the rgb_led_top module was created and the blinking_led module was instantiated within it. The board switches are used to select which RGB LED is active. If multiple switches are enabled, or if no switch is enabled, the RGB LED remains off. The blinking output from blinking_led is connected to the selected RGB LED so that the selected color blinks once every second.

# Verification and Results

For the blinking_led testbench, a 125 MHz clock was used. The reset behavior, disabled output, and LED toggling were tested. CLK_CYCLES_PER_TOGGLE was changed to 10 in the DUT so that the LED would toggle every 10 clock cycles, as specified in the lab requirements. In test 3, the testbench waits for 10 rising edges of sys_clk before checking that the LED output has toggled. All test cases passed, and the TEST PASSED message was displayed in the Tcl console.

![blinking_led_sim_result](https://github.com/anna-bagdishyan/Lab_1_LED_Blinker/blob/main/Screenshots/blinking_led_sim_result.png)\
Figure 1 - A screenshot of the simulation window for the blinking_led testbench.

For Task 1, a 125 MHz clock was used in the rgb_led_top testbench and CLK_CYCLES_PER_TOGGLE was changed to 10. The reset behavior, multiple switches being enabled, and the LED selection colors were tested. All five test cases passed, and TEST PASSED  was displayed in the Tcl console.

![rgb_led_sim_result](https://github.com/anna-bagdishyan/Lab_1_LED_Blinker/blob/main/Screenshots/rgb_led_sim_result.png)\
 
Figure 2 - A screenshot of the simulation window for the rgb_led_top testbench.

After the constraints were added and modified, the designs successfully passed synthesis and implementation, and bitstreams were generated. The LED behavior was then verified on the hardware. For Task 1, SW0, SW1, and SW2 correctly selected the red, green, and blue LEDs, and the selected color blinked once per second.


# Known Issues or Limitations

The design works as intended, with no current known issues.

# References
ECE 520/L Lab 1 - LED Blinker Manual.
