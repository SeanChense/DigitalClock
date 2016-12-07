----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:38:16 11/24/2016 
-- Design Name: 
-- Module Name:    En - Behavioral 
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

entity En is
    Port ( s : in  STD_LOGIC;
           e : out  STD_LOGIC);
end En;

architecture Behavioral of En is
	signal e1 : std_logic := '0';
begin

	process(s)
	begin
		if s'event and s = '1' then
			e1 <= not e1;
		end if;
	end process;
e <= e1;
end Behavioral;

