----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:52:14 11/24/2016 
-- Design Name: 
-- Module Name:    UnionCounter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UnionCounter is
    Port ( csignal : in  STD_LOGIC;
           clear 	 : in  STD_LOGIC;
			  count_en: in  STD_LOGIC;
           result1 : out  STD_LOGIC_VECTOR (3 downto 0);
           result2 : out  STD_LOGIC_VECTOR (3 downto 0);
           result3 : out  STD_LOGIC_VECTOR (3 downto 0);
           result4 : out  STD_LOGIC_VECTOR (3 downto 0);
           result5 : out  STD_LOGIC_VECTOR (3 downto 0);
           result6 : out  STD_LOGIC_VECTOR (3 downto 0));
end UnionCounter;

architecture Behavioral of UnionCounter is

	component Counter is
		 Port ( rst : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  carry_in : in  STD_LOGIC;
				  carry_out : out  STD_LOGIC;
				  count_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component Counter;

	component Counter_6 is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
			  carry_out : out  STD_LOGIC;
           count_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component Counter_6;
	
	signal carry1, carry2, carry3, carry4, carry5, carry6 : STD_LOGIC;
	
begin
	U1: Counter port map (	rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> count_en,
									carry_out	=> carry1,
									count_out 	=> result1);
									
	U2: Counter port map (	rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> carry1,
									carry_out	=> carry2,
									count_out 	=> result2);
									
	U3: Counter port map (	rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> carry2,
									carry_out	=> carry3,
									count_out 	=> result3);
									
	U4: Counter_6 port map (rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> carry3,
									carry_out	=> carry4,
									count_out 	=> result4);
									
	U5: Counter port map (	rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> carry4,
									carry_out	=> carry5,
									count_out 	=> result5);
									
	U6: Counter_6 port map (rst 			=> clear,
									clk 			=> csignal,
									carry_in 	=> carry5,
									carry_out	=> carry6,
									count_out 	=> result6);
									
end Behavioral;

