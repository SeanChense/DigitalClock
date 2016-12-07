----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:25:50 12/04/2016 
-- Design Name: 
-- Module Name:    Latch - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Latch is
    Port ( latchin : in  STD_LOGIC;
           readLatch : in  STD_LOGIC;
           numin1 : in  STD_LOGIC_VECTOR (3 downto 0);
           numin2 : in  STD_LOGIC_VECTOR (3 downto 0);
           numin3 : in  STD_LOGIC_VECTOR (3 downto 0);
           numin4 : in  STD_LOGIC_VECTOR (3 downto 0);
           numin5 : in  STD_LOGIC_VECTOR (3 downto 0);
           numin6 : in  STD_LOGIC_VECTOR (3 downto 0);
           numout1 : out  STD_LOGIC_VECTOR (3 downto 0);
           numout2 : out  STD_LOGIC_VECTOR (3 downto 0);
           numout3 : out  STD_LOGIC_VECTOR (3 downto 0);
           numout4 : out  STD_LOGIC_VECTOR (3 downto 0);
           numout5 : out  STD_LOGIC_VECTOR (3 downto 0);
           numout6 : out  STD_LOGIC_VECTOR (3 downto 0));
end Latch;

architecture Behavioral of Latch is
signal l1, l2, l3, l4, l5, l6 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal flag : STD_LOGIC := '1'; 
begin

	
	process(latchin)
	begin
		if latchin = '1' then 
			l1 <= numin1;
			l2 <= numin2;
			l3 <= numin3;
			l4 <= numin4;
			l5 <= numin5;
			l6 <= numin6;
		end if;
	end process;
	
	process(readLatch)
	begin
		if readLatch'event and readLatch ='1' then
			flag <= not flag;
		end if;
	end process;
	
	process(flag)
	begin
		if flag = '1' then
			numout1  <= l1;
			numout2  <= l2;
			numout3  <= l3;
			numout4  <= l4;
			numout5  <= l5;
			numout6  <= l6;
		else 
			numout1  <= numin1;
			numout2  <= numin2;
			numout3  <= numin3;
			numout4  <= numin4;
			numout5  <= numin5;
			numout6  <= numin6;
		end if;
	end process;
	
	
	
end Behavioral;



