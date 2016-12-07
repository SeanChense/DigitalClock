------------------------------------------------------------------
-- Copyright (c) 1995-2005 Xilinx, Inc.
-- All Right Reserved.
------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : 
--  /   /         Filename : vgacore_multi.vhd
-- /___/   /\     Timestamp : 9/20/2005 11:06:08
-- \   \  /  \ 
--  \___\/\___\ 
--
-- 
--     This Entity contains the VGA display control. 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vgacore is Port ( 
	CLK : 	in std_logic;
	RESET: 	in std_logic;
	HSYNCH:  out std_logic;
	VSYNCH:	out std_logic;
	HBLANK: 	out std_logic;
	LINE: 	out std_logic_vector(5 downto 0);
	PIXEL: 	out std_logic_vector(6 downto 0)
	);
end vgacore;

architecture behavioral of vgacore is

signal TEMP_PIXEL: std_logic_vector( 9 downto 0 );
signal TEMP_LINE: std_logic_vector(8 downto 0);

signal HCOUNTER : integer range 1023 downto 0 := 0;
signal COUNTER_RESET: std_logic;
signal VCLK: std_logic;

signal VCOUNTER : integer range 1023 downto 0 := 0;
signal VERTICAL_COUNTER_RESET: std_logic;

begin

------------------------------------------------------------------------------
-- State Machine Counter Process 
-- 
-- This counter is to be used as a common resource for state machine control
-- 
------------------------------------------------------------------------------
horizontal_counter: process ( CLK, COUNTER_RESET )
begin
	if COUNTER_RESET = '1' then
		HCOUNTER <= 0;
	elsif CLK='1' and CLK'event then
     	HCOUNTER <= HCOUNTER + 1;
   end if;
end process;

vertical_counter: process ( VCLK, VERTICAL_COUNTER_RESET )
begin
	if VERTICAL_COUNTER_RESET = '1' then
		VCOUNTER <= 0;
	elsif VCLK = '1' and VCLK'event then
     	VCOUNTER <= VCOUNTER + 1;
   end if;
end process;

------------------------------------------------------------------------------
-- Horizontal State Machine
------------------------------------------------------------------------------
Horizontal: process ( CLK, RESET )

type HSTATE is ( HRESET, FRONT_PORCH, SYNCH, BACK_PORCH, LEFT_BORDER, ACTIVE_VIDEO, RIGHT_BORDER );
variable Horizontal_State : HSTATE := HRESET;

variable PIXEL_COUNT : integer := 0;

begin

	if ( RESET = '1' ) then
		Horizontal_State := HRESET;
		COUNTER_RESET <= '1';
		HSYNCH <= '1';
		VCLK <= '0';
		HBLANK <= '1';
	elsif ( CLK = '1' and CLK'EVENT ) then

		VCLK <= '0';
		HBLANK <= '1';
		PIXEL <= ( others => '0' );		

		case ( Horizontal_State ) is
			when HRESET =>
				Horizontal_State := LEFT_BORDER;
				COUNTER_RESET <= '1';
				HSYNCH <= '1';

			-- Want 8 Left Border Pixels
			-- Less one Pixel because of Counter Reset Delay for Active Video
			when LEFT_BORDER 	=>
				if (HCOUNTER = 4) then				-- HCOUNTER = 27
					Horizontal_State := ACTIVE_VIDEO;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
				else
					Horizontal_State := LEFT_BORDER;
					COUNTER_RESET <= '0';
					HSYNCH <= '1';
				end if;

			-- Want 640 Left Border Pixels
			when ACTIVE_VIDEO =>
			
				HBLANK <= '0';
				TEMP_PIXEL <= CONV_STD_LOGIC_VECTOR(HCOUNTER,10);

				PIXEL( 6 downto 0 ) <= TEMP_PIXEL( 9 downto 3 );

				if (HCOUNTER = 639) then			 
					Horizontal_State := RIGHT_BORDER;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
				else
					Horizontal_State := ACTIVE_VIDEO;
					COUNTER_RESET <= '0';
					HSYNCH <= '1';
				end if;

			-- Want 8 Right Border Pixels
			when RIGHT_BORDER =>
				if (HCOUNTER = 5) then				-- HCOUNTER = 27
					Horizontal_State := FRONT_PORCH;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
				else
					Horizontal_State := RIGHT_BORDER;
					COUNTER_RESET <= '0';
					HSYNCH <= '1';
				end if;

			-- Want 8 Front porch Pixels
			when FRONT_PORCH =>
				if (HCOUNTER = 7) then				
					Horizontal_State := SYNCH;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
					VCLK <= '1';
				else
					Horizontal_State := FRONT_PORCH;
					COUNTER_RESET <= '0';
					HSYNCH <= '1';
				end if;
					
			-- Want 96 Synch Pixels
			when SYNCH =>
				if (HCOUNTER = 95) then				 
					Horizontal_State := BACK_PORCH;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
				else
					Horizontal_State := SYNCH;
					COUNTER_RESET <= '0';
					HSYNCH <= '0';
				end if;

			-- Want 40 Back Porch Pixels
			when BACK_PORCH =>
				if (HCOUNTER = 38) then				-- HCOUNTER = 39
					Horizontal_State := LEFT_BORDER;
					COUNTER_RESET <= '1';
					HSYNCH <= '1';
				else
					Horizontal_State := BACK_PORCH;
					COUNTER_RESET <= '0';
					HSYNCH <= '1';
				end if;

			when others =>
				Horizontal_State := HRESET;
				COUNTER_RESET <= '1';
				HSYNCH <= '1';
			end case;
	end if;

end process;

------------------------------------------------------------------------------
-- Horizontal State Machine
------------------------------------------------------------------------------
Vertical: process ( VCLK, RESET )

type VSTATE is ( VRESET, FRONT_PORCH, SYNCH, BACK_PORCH, TOP_BORDER, ACTIVE_VIDEO, BOTTOM_BORDER );
variable Vertical_State : VSTATE := VRESET;

variable LINE_COUNT : integer := 0;

begin

	if ( RESET = '1' ) then
		Vertical_State := VRESET;
		
		VERTICAL_COUNTER_RESET <= '1';
		VSYNCH <= '1';
	
	elsif ( VCLK = '1' and VCLK'EVENT ) then

		LINE <= ( others => '0' );
		
		case ( Vertical_State ) is
			when VRESET =>
				Vertical_State := TOP_BORDER;
				VERTICAL_COUNTER_RESET <= '1';
				VSYNCH <= '1';

			-- Want 8 Front porch Pixels
			when FRONT_PORCH =>
				if (VCOUNTER = 1) then				
					Vertical_State := SYNCH;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := FRONT_PORCH;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '1';
				end if;
					
			-- Want 96 Synch Pixels
			when SYNCH =>
				if (VCOUNTER = 1) then				 
					Vertical_State := BACK_PORCH;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := SYNCH;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '0';
				end if;

			-- Want 40 Back Porch Pixels
			when BACK_PORCH =>
				if (VCOUNTER = 23) then				-- HCOUNTER = 39
					Vertical_State := TOP_BORDER;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := BACK_PORCH;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '1';
				end if;

			-- Want 8 Left Border Pixels
			-- Less one Pixel because of Counter Reset Delay for Active Video
			when TOP_BORDER 	=>
				if (VCOUNTER = 4) then				-- HCOUNTER = 27
					Vertical_State := ACTIVE_VIDEO;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := TOP_BORDER;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '1';
				end if;

			-- Want 640 Left Border Pixels
			when ACTIVE_VIDEO =>
				TEMP_LINE <= CONV_STD_LOGIC_VECTOR(VCOUNTER,9);

				LINE <= TEMP_LINE(8 downto 3);

				if (VCOUNTER = 479) then			 
					Vertical_State := BOTTOM_BORDER;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := ACTIVE_VIDEO;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '1';
				end if;

			-- Want 8 Right Border Pixels
			when BOTTOM_BORDER =>

				if (VCOUNTER = 5) then				-- HCOUNTER = 27
					Vertical_State := FRONT_PORCH;
					VERTICAL_COUNTER_RESET <= '1';
					VSYNCH <= '1';
				else
					Vertical_State := BOTTOM_BORDER;
					VERTICAL_COUNTER_RESET <= '0';
					VSYNCH <= '1';
				end if;

			when others =>
				Vertical_State := VRESET;
				VERTICAL_COUNTER_RESET <= '1';
				VSYNCH <= '1';
			end case;
	end if;
 
end process;

end behavioral;