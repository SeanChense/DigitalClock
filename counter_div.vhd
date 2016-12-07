--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:42:30 11/24/2016
-- Design Name:   
-- Module Name:   D:/DigitalClock/counter_div.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
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
 
ENTITY counter_div IS
END counter_div;
 
ARCHITECTURE behavior OF counter_div IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         carry_in : IN  std_logic;
         carry_out : OUT  std_logic;
         count_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal carry_in : std_logic := '0';


   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          rst => rst,
          clk => clk,
          carry_in => carry_in,
          carry_out => carry_out,
          count_out => count_out
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

      -- insert stimulus here 

      wait;
   end process;

END;
