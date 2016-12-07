----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:27:59 11/24/2016 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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

entity Counter is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           count_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end Counter;

architecture Behavioral of Counter is
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
begin
process(rst, clk)
begin

IF rst = '1' then
	count <= "0000";
elsif clk'event and clk = '1' then
	if carry_in = '1' then 
		if count < "1001" then 
			count <= count + 1;
		else
			count <= "0000";
		end if;
	else null;
	end if;
end if;

end process;
count_out <= count;
carry_out <= '1' when carry_in = '1' and count = "1001" else '0';
		
end Behavioral;

