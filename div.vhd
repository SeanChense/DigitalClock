--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:01:14 11/24/2016
-- Design Name:   
-- Module Name:   D:/DigitalClock/DIV.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DigitalClock
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DIV IS
END DIV;
 
ARCHITECTURE behavior OF DIV IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DigitalClock
    PORT(
         CLKIN : IN  std_logic;
         reset : IN  std_logic;
         save : IN  std_logic;
         resume : IN  std_logic;
         CLKOUT_1K : OUT  std_logic;
         CLKOUT_100 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLKIN : std_logic := '1';
   signal reset : std_logic := '0';
   signal save : std_logic := '0';
   signal resume : std_logic := '0';

 	--Outputs
   signal CLKOUT_1K : std_logic;
   signal CLKOUT_100 : std_logic;

   -- Clock period definitions
   constant CLKIN_period : time := 10 ns;
--   constant CLKOUT_1K_period : time := 10 ns;
--   constant CLKOUT_100_period : time := 10 ns;
-- 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DigitalClock PORT MAP (
          CLKIN => CLKIN,
          reset => reset,
          save => save,
          resume => resume,
          CLKOUT_1K => CLKOUT_1K,
          CLKOUT_100 => CLKOUT_100
        );

   -- Clock process definitions
   CLKIN_process :process
   begin
		CLKIN <= '0';
		wait for CLKIN_period/2;
		CLKIN <= '1';
		wait for CLKIN_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait;
   end process;

END;
