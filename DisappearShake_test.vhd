--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:51:43 11/25/2016
-- Design Name:   
-- Module Name:   C:/Users/Acer/Desktop/DigitalClock/DisappearShake_test.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DisappearShake
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
 
ENTITY DisappearShake_test IS
END DisappearShake_test;
 
ARCHITECTURE behavior OF DisappearShake_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DisappearShake
    PORT(
         clk : IN  std_logic;
         sin : IN  std_logic;
         sout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal sin : std_logic := '0';

 	--Outputs
   signal sout : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DisappearShake PORT MAP (
          clk => clk,
          sin => sin,
          sout => sout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      sin <= '1';
		wait for 101 ns;
		
		sin <= '0';
		
		wait for 1 ns;
		
		sin <= '1';
		wait for 1 ns;

      wait;
   end process;

END;
