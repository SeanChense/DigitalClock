--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:32:57 11/24/2016
-- Design Name:   
-- Module Name:   D:/DigitalClock/Display_test.vhd
-- Project Name:  DigitalClock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Display
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
 
ENTITY Display_test IS
END Display_test;
 
ARCHITECTURE behavior OF Display_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Display
    PORT(
         clk : IN  std_logic;
         mh : IN  std_logic_vector(3 downto 0);
         ml : IN  std_logic_vector(3 downto 0);
         sh : IN  std_logic_vector(3 downto 0);
         sl : IN  std_logic_vector(3 downto 0);
         ds : IN  std_logic_vector(3 downto 0);
         cs : IN  std_logic_vector(3 downto 0);
         sel : OUT  std_logic_vector(2 downto 0);
         led : OUT  std_logic_vector(6 downto 0);
         g : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal mh : std_logic_vector(3 downto 0) := (others => '0');
   signal ml : std_logic_vector(3 downto 0) := (others => '0');
   signal sh : std_logic_vector(3 downto 0) := (others => '0');
   signal sl : std_logic_vector(3 downto 0) := (others => '0');
   signal ds : std_logic_vector(3 downto 0) := (others => '0');
   signal cs : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal sel : std_logic_vector(2 downto 0);
   signal led : std_logic_vector(6 downto 0);
   signal g : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Display PORT MAP (
          clk => clk,
          mh => mh,
          ml => ml,
          sh => sh,
          sl => sl,
          ds => ds,
          cs => cs,
          sel => sel,
          led => led,
          g => g
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
