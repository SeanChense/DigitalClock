----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:23:07 11/25/2016 
-- Design Name: 
-- Module Name:    Decoder38 - Behavioral 
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



entity Decoder38 is
    Port ( DIN : in  STD_LOGIC_VECTOR (2 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0));
end Decoder38;
architecture Behavioral of Decoder38 is

begin
	with DIN select
		DOUT <= "11111110" when "000",
		"11111101" when "001",
		"11111011" when "010",
		"11110111" when "011",
		"11101111" when "100",
		"11011111" when "101",
		"10111111" when "110",
		"01111111" when "111",
		"XXXXXXXX" when others;
end Behavioral;

