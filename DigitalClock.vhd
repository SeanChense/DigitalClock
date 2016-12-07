----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:51 11/24/2016 
-- Design Name: 
-- Module Name:    DigitalClock - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Divider is
    Port ( CLKIN	: in  STD_LOGIC;
			  reset 	: in  STD_LOGIC;
           save 	: in  STD_LOGIC;
           resume : in  STD_LOGIC;
			  
			  CLKOUT_1K 	: OUT STD_LOGIC;
			  CLKOUT_100	: OUT STD_LOGIC);
end Divider;


