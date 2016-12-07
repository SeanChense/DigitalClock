----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:09 11/24/2016 
-- Design Name: 
-- Module Name:    Display - Behavioral 
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

entity Display is --实际上是个多路选择器
    Port ( clk : in  STD_LOGIC;
           mh : in  STD_LOGIC_VECTOR (3 downto 0);
           ml : in  STD_LOGIC_VECTOR (3 downto 0);
           sh : in  STD_LOGIC_VECTOR (3 downto 0);
           sl : in  STD_LOGIC_VECTOR (3 downto 0);
           ds : in  STD_LOGIC_VECTOR (3 downto 0);
           cs : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : out  STD_LOGIC_VECTOR (2 downto 0);
           led : out  STD_LOGIC_VECTOR (6 downto 0);
           g : out  STD_LOGIC);
end Display;

architecture Behavioral of Display is
	signal cnt	: std_logic_vector(2 downto 0) := "000";
	signal data	: std_logic_vector(3 downto 0);
begin
	scan : process(clk)
	begin
		if rising_edge(clk) then
			if cnt = "101" then
				cnt <= "000";
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;
	
	muxe: process(cnt, mh, ml, sh, sl, ds, cs)
	begin
		case cnt is 
			when "000" => data <= cs;
			when "001" => data <= ds;
			when "010" => data <= sl;
			when "011" => data <= sh;
			when "100" => data <= ml;
			when others
						  => data <= mh;
		end case;
	end process;
	
	bcd2led : process(data)
	begin 	
		led <= "1111111";
		case data is 
			when "0000" => led <= "0000001";
			when "0001" => led <= "1001111";
			when "0010" => led <= "0010010";
			when "0011" => led <= "0000110";
			when "0100" => led <= "1001100";
			when "0101" => led <= "0100100";
			when "0110" => led <= "0100000";
			when "0111" => led <= "0001111";
			when "1000" => led <= "0000000";
			when "1001" => led <= "0000100";
			when others => null;
		end case;
	end process;
	
	g <= '0';
	sel <= cnt;


end Behavioral;

