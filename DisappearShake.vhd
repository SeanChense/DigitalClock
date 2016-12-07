----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:41:45 11/25/2016 
-- Design Name: 
-- Module Name:    DisappearShake - Behavioral 
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

entity DisappearShake is
    Port ( clk : in  STD_LOGIC;
           sin : in  STD_LOGIC;
           sout : out  STD_LOGIC);
end DisappearShake;

architecture Behavioral of DisappearShake is
signal cnt : integer range 1 to 20;
begin

	process(clk)
	begin
		if clk'event and clk ='1' then
			if sin = '0' then
				sout <= '0';
				cnt <= 1;
			elsif cnt = 20 then
				sout <= '1';
				cnt <= 1;
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;

end Behavioral;


