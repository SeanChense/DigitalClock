----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:50 11/24/2016 
-- Design Name: 
-- Module Name:    Divider - Behavioral 
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


entity Divider is
    Port ( CLKIN : in  STD_LOGIC;
           CLKOUT_1K : out  STD_LOGIC;
           CLKOUT_100 : out  STD_LOGIC);
end Divider;

architecture Behavioral of Divider is
SIGNAL COUNTER1 : INTEGER RANGE 0 TO 23999 := 0; --计数器 1， 分频为 1kHz
SIGNAL COUNTER2 : INTEGER RANGE 0 TO 4		 := 0; --计数器 2， 进一步分频得到 100Hz
SIGNAL CLKOUT_1K_TEP, CLKOUT_100_TEP: STD_LOGIC := '0';

begin

------------------------------- 分频器 1kHz ---------------------------
PROCESS(CLKIN) IS

BEGIN 
	IF CLKIN'EVENT AND CLKIN = '1' THEN
		IF COUNTER1 = 23999 THEN 
			COUNTER1 <= 0;
			CLKOUT_1K_TEP <= NOT CLKOUT_1K_TEP;
		ELSE
			COUNTER1 <= COUNTER1 + 1;
		END IF;
	END IF;

END PROCESS;

CLKOUT_1K <= CLKOUT_1K_TEP;

------------------------------- 分频器 100Hz ---------------------------
P2:PROCESS(CLKOUT_1K_TEP) IS
BEGIN
	IF CLKOUT_1K_TEP'EVENT AND CLKOUT_1K_TEP = '1' THEN 
		IF COUNTER2 = 4 THEN
			COUNTER2 <= 0;
			CLKOUT_100_TEP <= NOT CLKOUT_100_TEP;
		ELSE 
			COUNTER2 <= COUNTER2 + 1;
		END IF;
	END IF;
END PROCESS;
CLKOUT_100 <= CLKOUT_100_TEP; 
 
end Behavioral;

