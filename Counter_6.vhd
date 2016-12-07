----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:06:24 11/24/2016 
-- Design Name: 
-- Module Name:    Counter_6 - Behavioral 
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

entity Counter_6 is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
			  carry_out : out  STD_LOGIC;
           count_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end Counter_6;

architecture Behavioral of Counter_6 is
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
begin
process(rst, clk)
begin

IF rst = '1' then
	count <= "0000";
elsif clk'event and clk = '1' then
	if carry_in = '1' then 
		if count < "0101" then 
			count <= count + 1;
		else
			count <= "0000";
		end if;
	else null;
	end if;
end if;

end process;
count_out <= count;
carry_out <= '1' when carry_in = '1' and count = "0101" else '0';
		
end Behavioral;
