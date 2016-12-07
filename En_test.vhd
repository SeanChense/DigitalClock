--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:43:07 11/24/2016
-- Design Name:   
-- Module Name:   D:/DigitalClock/En_test.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: En
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
 
ENTITY En_test IS
END En_test;
 
ARCHITECTURE behavior OF En_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT En
    PORT(
         s : IN  std_logic;
         e : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal s : std_logic := '1';

 	--Outputs
   signal e : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: En PORT MAP (
          s => s,
          e => e
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      s <= '1';
		wait for 100ns;
		s <= '0';
		wait for 100ns;
		
      s <= '1';
		wait for 100ns;
		s <= '0';
		wait for 100ns;
		
      s <= '1';
		wait for 100ns;
		s <= '0';
		wait for 100ns;
		
      s <= '1';
		wait for 100ns;
		s <= '0';
		wait for 100ns;
		
      s <= '1';
		wait for 100ns;
		s <= '0';
		wait for 100ns;
   end process;

END;
