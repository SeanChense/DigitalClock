------------------------------------------------------------------
-- Copyright (c) 1995-2005 Xilinx, Inc.
-- All Right Reserved.
------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : 
--  /   /         Filename : vga_interface.vhd
-- /___/   /\     Timestamp : 9/20/2005 11:15:08
-- \   \  /  \ 
--  \___\/\___\ 
--
-- 
--   This Entity interprets the color output to the VGA monitor

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_int is Port ( 
	CLK :			in  std_logic;
	COLOR: 		in  std_logic_vector ( 1 downto 0 );
	VSYNCH_IN: 	in  std_logic;
	HSYNCH_IN: 	in  std_logic;
	RED:			out std_logic;
	BLUE:			out std_logic;
	GREEN:		out std_logic;
	VSYNCH_OUT:	out std_logic;
	HSYNCH_OUT:	out std_logic
	);
end vga_int;

architecture behavioral of vga_int is

signal VSYNCH_PIPE: std_logic;
signal HSYNCH_PIPE: std_logic;

begin

PIPELINE: process	 (CLK)
begin
	if ( CLK = '1' and CLK'event ) then
		VSYNCH_OUT  <= VSYNCH_PIPE;
		HSYNCH_OUT  <= HSYNCH_PIPE;
		HSYNCH_PIPE <= HSYNCH_IN;
		VSYNCH_PIPE <= VSYNCH_IN;
	end if;
end process;

COLOR_LUT: process  (CLK)
begin
	if ( CLK = '1' and CLK'event ) then
		RED 	<= '0';
		GREEN <= '0';
		BLUE 	<= '0';

		case COLOR is
				when "00" => 
					RED 	<= '0';
					GREEN <= '0';
					BLUE 	<= '0';
				when "01" => 
					RED 	<= '1';
					GREEN <= '0';
					BLUE 	<= '0';
				when "10" => 
					RED 	<= '0';
					GREEN <= '0';
					BLUE 	<= '1';
				when "11" => 
					RED 	<= '1';
					GREEN <= '1';
					BLUE 	<= '1';
				when others => NULL;
			end case;						
	end if;
end process;

end behavioral;