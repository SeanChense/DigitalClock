--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:10:25 11/24/2016
-- Design Name:   
-- Module Name:   D:/DigitalClock/UnionCounter_test.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UnionCounter
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
 
ENTITY UnionCounter_test IS
END UnionCounter_test;
 
ARCHITECTURE behavior OF UnionCounter_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UnionCounter
    PORT(
         csignal : IN  std_logic;
         clear : IN  std_logic;
         count_en : IN  std_logic;
         result1 : OUT  std_logic_vector(3 downto 0);
         result2 : OUT  std_logic_vector(3 downto 0);
         result3 : OUT  std_logic_vector(3 downto 0);
         result4 : OUT  std_logic_vector(3 downto 0);
         result5 : OUT  std_logic_vector(3 downto 0);
         result6 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal csignal : std_logic := '0';
   signal clear : std_logic := '0';
   signal count_en : std_logic := '1';

 	--Outputs
   signal result1 : std_logic_vector(3 downto 0);
   signal result2 : std_logic_vector(3 downto 0);
   signal result3 : std_logic_vector(3 downto 0);
   signal result4 : std_logic_vector(3 downto 0);
   signal result5 : std_logic_vector(3 downto 0);
   signal result6 : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace csignal below with 
   -- appropriate port name 
 
   constant csignal_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UnionCounter PORT MAP (
          csignal => csignal,
          clear => clear,
          count_en => count_en,
          result1 => result1,
          result2 => result2,
          result3 => result3,
          result4 => result4,
          result5 => result5,
          result6 => result6
        );

   -- Clock process definitions
   csignal_process :process
   begin
		csignal <= '0';
		wait for csignal_period/2;
		csignal <= '1';
		wait for csignal_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for csignal_period*10;

      -- insert stimulus here 

      wait;
   end process;
END;
