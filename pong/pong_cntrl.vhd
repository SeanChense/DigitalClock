------------------------------------------------------------------
-- Copyright (c) 1995-2005 Xilinx, Inc.
-- All Right Reserved.
------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : 
--  /   /         Filename : pong_cntrl.vhd
-- /___/   /\     Timestamp : 9/20/2005 11:01:05
-- \   \  /  \ 
--  \___\/\___\ 
--
-- This module displays the title, PONG, on the four seven segment LEDs of the Spartan3 Demo Board
--   

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cntrl is Port (
	CLK : 	in std_logic;
	RESET: 	in std_logic;
	left_dir:		in std_logic_vector(1 downto 0);
	right_dir:	in std_logic_vector(1 downto 0);
	SERVE:	in std_logic;
	HSYNCH:  out std_logic;
	VSYNCH:	out std_logic;
	COLOR:	out std_logic_vector( 1 downto 0 )
	);
end cntrl;

architecture static_display of cntrl is

component vgacore is Port ( 
	CLK : 	in std_logic;
	RESET: 	in std_logic;
	HSYNCH:  out std_logic;
	VSYNCH:	out std_logic;
	HBLANK: 	out std_logic;
	LINE: 	out std_logic_vector(5 downto 0);
	PIXEL: 	out std_logic_vector(6 downto 0)
	);
end component;

component testram is Port ( 
	address: in std_logic_vector( 6 downto 0 );
	data: 	out std_logic_vector( 3 downto 0 )
	);
end component;

signal	number_data: std_logic_vector( 3 downto 0 );
signal   number_address: std_logic_vector( 6 downto 0 );
signal	enable: std_logic;

signal	LINE:	 	std_logic_vector( 5 downto 0 );
signal	PIXEL: 	std_logic_vector( 6 downto 0 );
signal	HBLANK: 	std_logic;

signal	next_HSYNCH:	std_logic;
signal	next_VSYNCH:	std_logic;
signal	VCLK: std_logic;
signal   next_COLOR: 	std_logic_vector( 1 downto 0 );

constant ball_height: integer := 1;
constant ball_width: integer := 2;

constant paddle_height: integer := 8;
constant paddle_heighta: integer := 4;	-- defines top 1/4 of paddle
constant paddle_heightb: integer := 6;	-- defines middle 1/2 of paddle
constant paddle_heightc: integer := 8;	-- defines bottom 1/4 of paddle
constant paddle_width: integer := 2;	-- defines width of paddle

constant wall_height: integer := 1;
constant wall_top: integer := 9;
constant wall_bottom: integer := 58;
constant right_wall: integer := 77;
constant left_wall: integer := 2;

constant right_score_x: integer:= 64;
constant right_score_y: integer:= 4;
constant left_score_x: integer:= 16;
constant left_score_y: integer:= 4;
constant score_width: integer := 4;
constant score_height: integer := 4;

constant right_x: integer := 72;
constant left_x: integer := 8;

signal ball_xdir, ball_ydir: std_logic;
signal ball_x: integer range 0 to 80;
signal ball_y: integer range 0 to 60 := 30;
signal ball_yrate: integer range 0 to 3;

signal left_y: std_logic_vector(5 downto 0);
signal right_y: std_logic_vector(5 downto 0);
signal nextleft_y: std_logic_vector(5 downto 0);
signal nextright_y: std_logic_vector(5 downto 0);

signal delay: std_logic_vector(2 downto 0);		-- Delay vector is used to slow down the speed of the ball

signal lscore, rscore: integer range 0 to 9 := 0;

begin


-- VGA CORE Instantiation
VGA1: vgacore port map (
	CLK => CLK,
	RESET=> RESET,
	HSYNCH=> next_HSYNCH,
	VSYNCH=> next_VSYNCH,
	HBLANK=> HBLANK,
	LINE=> LINE,
	PIXEL=> PIXEL
	);

-- Character generator memory instantiation
CGEN1: testram port map ( 
	address	=> number_address ,
	data		=> number_data
	);

-- Pipeline the control signals to account for Game Delay
pipeline: process ( clk, pixel, line)
begin
	if ( clk = '1' and clk'event) then
		VSYNCH <= next_VSYNCH;
		VCLK <= next_VSYNCH;
		HSYNCH <= next_HSYNCH;
		if ( HBLANK = '1' ) then
			color <= "00";
		else
			color <= next_COLOR;
		end if;
	end if;
end process;

-- Code to display the ball and paddles
display: process (clk, line, pixel, left_y, right_y, ball_x, ball_y, lscore, number_data, rscore)
begin

	number_address(2 downto 0) <= line(2 downto 0);
	
	-- Display Background Color
	next_COLOR <= "00";

	-- Display the playing field top bar
		if ( line = wall_top  ) then
				next_COLOR <= "11";
		end if;

	-- Display the playing field bottom bar
		if ( line = wall_bottom ) then
				next_COLOR <= "11";
		end if;

	-- Display the left Paddle:
		if (( pixel = left_x -1)  ) then
			if ( (line >= left_y ) and (line <= (left_y + paddle_height)) ) then
				next_COLOR <= "11";
			end if;
		end if;
		
	-- Display the right Paddle:
		if ( pixel = right_x + 1 ) then
			if ( (line >= right_y) and (line <= (right_y + paddle_height)) ) then
				next_COLOR <= "11";
			end if;
		end if;

	-- Display the Ball:
		if ( (pixel = ball_x) ) then
			if ( line = ball_y ) then
				next_COLOR <= "11";
			end if;
		end if;

	-- Display the Left Score ( Using Std_Logic_Vectors instead of integers )
	if ( clk = '1' and clk'event) then	
		if ((pixel >= "0001000" ) and ( pixel <= "0001011" )) and			 
				((line >= "000000" ) and (line <= "000111" )) then
					number_address(6 downto 3) <= CONV_STD_LOGIC_VECTOR(lscore,4);
		elsif ((pixel >= "01000000" ) and ( pixel <= "01000011" )) and
				((line >= "000000" ) and (line <= "000111" )) then
					number_address(6 downto 3) <= CONV_STD_LOGIC_VECTOR(rscore,4);
		else
				number_address(6 downto 3) <= "0001";
		end if;
	end if;					 

		if ((pixel >= "0001000") and (pixel <= "0001011" )) and	
			((line >= "000000") and (line <= "000111" ) ) then
				case pixel( 1 downto 0 ) is
					when "00" =>
						if ( number_data(3) = '1' ) then
							next_COLOR <= "10";
						end if;
					when "01" =>
						if ( number_data(2) = '1' ) then
							next_COLOR <= "10";
						end if;
					when "10" =>
						if ( number_data(1) = '1' ) then
							next_COLOR <= "10";
						end if;
					when "11" =>
						if ( number_data(0) = '1' ) then
							next_COLOR <= "10";
						end if;
					when others => NULL;
				end case;
		end if;

	-- Display the Right Score

		if ((pixel >= "01000000") and (pixel <= "01000011" )) and
			((line >= "000000") and (line <= "000111")) then
 			   case pixel(1 downto 0) is
					when "00" =>
						if (number_data(3) = '1') then
							next_COLOR <= "10";
						end if;
					when "01" =>
						if (number_data(2) = '1') then
							next_COLOR <= "10";
						end if;
					when "10" =>
						if (number_data(1) = '1') then
							next_COLOR <= "10";
						end if;
					when "11" =>
						if (number_data(0) = '1') then
							next_COLOR <= "10";
						end if;
					when others => NULL;
				end case;
		end if;

end process;

-- Game play logic
moving_paddles: process (VCLK, reset)
  begin
	if (reset = '1') then
		left_y <= "001001";
		right_y <= "001001";
		nextleft_y <= "001001";
		nextright_y <= "001001";
	elsif (VCLK = '1' and VCLK'event) then
 		
		if (left_dir = "10") then
			nextleft_y <= nextleft_y + 1;	 -- move up
		elsif (left_dir = "01") then
			nextleft_y <= nextleft_y - 1;	 -- move down
		else
			nextleft_y <= nextleft_y;	 	 -- don't move
		end if;
		
		if (right_dir = "10") then
			nextright_y <= nextright_y + 1;	-- move up
		elsif (right_dir = "01") then		
			nextright_y <= nextright_y - 1;	-- move down
		else 											
			nextright_y <= nextright_y;		-- don't move
		end if;
		
		if (nextleft_y < 9) then 
			left_y <= "001001";				   -- stop at top of screen
			nextleft_y <= "001001";		 	 
		elsif(nextleft_y > 50) then		 
			left_y <= "110010";				   -- stop at bottom of screen
			nextleft_y <= "110010";
		else
			left_y <= nextleft_y;
		end if;

		if ( nextright_y < 9 ) then
			right_y <= "001001";					-- stop at top of screen
			nextright_y <= "001001";
		elsif( nextright_y > 50 ) then
			right_y <= "110010";					-- stop at bottom of screen
			nextright_y <= "110010";
		else
			right_y <= nextright_y;
		end if;
	 end if;
end process;

moving_ball: process (VCLK, ball_xdir, ball_ydir, ball_x, ball_y, reset)
begin
 
	if (reset = '1') then
		ball_x <= left_wall;
		ball_y <= 32;
		ball_yrate <= 1;
		lscore <= 0;
		rscore <= 0;
		enable <= '0';
		delay <= "000";
	elsif (VCLK = '1' and VCLK'event) then
	   if (delay >= "100") then	--This value may be increased or decreased to adjust the speed of the ball
		  delay <= "000";
			if (SERVE = '1') then
				if (enable = '0' ) then
					ball_yrate <= 0;
				  	ball_y <= 16;
				end if;
				ball_y <= 32;
				enable <= '1';
			end if;

			if (ball_xdir = '1') then				 -- Horizontal Movement ( 1 = right )
				if (enable = '1') then
					ball_x <= ball_x + 1;
				end if;

				-- check for hit on upper 1/4 of right paddle
				if  ((ball_x = right_x) and ( ball_y >= right_y - ball_height ) and ( ball_y < right_y + paddle_heighta) ) then
					ball_xdir <= '0';
					-- if ball is going down
					if ( ball_ydir = '0' ) then 
						if ( ball_yrate > 0 ) then
							ball_yrate <= ball_yrate - 1;
						else
							ball_yrate <= 1;
							ball_ydir <= '1';
						end if;

					-- if ball is going up
				  	else
						if ( ball_yrate < 2 ) then
							ball_yrate <= ball_yrate + 1;
						else
							ball_yrate <= 2;
						end if;
					end if;

				elsif  ((ball_x = right_x) and ( ball_y >= right_y + paddle_heighta) and ( ball_y < right_y + paddle_heightb) ) then
					ball_xdir <= '0';

				-- check for hit on lower half of right paddle
				elsif  ((ball_x = right_x) and ( ball_y >= right_y + paddle_heightb) and ( ball_y <= right_y + paddle_heightc) ) then
						ball_xdir <= '0';
					-- if ball is going down
					if (ball_ydir = '0') then 
						if (ball_yrate < 2) then
							ball_yrate <= ball_yrate + 1;
						else
							ball_yrate <= 2;
						end if;
					-- if ball is going up
				  	else
						if (ball_yrate > 0) then
							ball_yrate <= ball_yrate - 1;
						else
							ball_ydir <= '0';
							ball_yrate <= 1;
						end if;
					end if;
					
				-- Score for left team
				else
					if (ball_x = right_wall) then			
						ball_xdir <= '0';	
						if (enable = '1') then
							if (lscore = 9) then
								lscore <= 0;
							else 
								lscore <= lscore + 1;
							end if;
						end if;
						enable <= '0';
					end if;
				end if;

			-- Ball going left
			else 
				-- in middle of playing field
				if ( enable = '1' ) then
					ball_x <= ball_x - 1;
				end if;

				if ( ball_x = left_x ) then

				-- upper portion of paddle
					if (( ball_y >= left_y ) and ( ball_y < left_y + paddle_heighta )) then
						ball_xdir <= '1';
						-- if ball is going down
						if ( ball_ydir = '0' ) then 
							if ( ball_yrate > 0 ) then
								ball_yrate <= ball_yrate - 1;
							else
								ball_ydir <= '1';
								ball_yrate <= 1;
							end if;
						-- if ball is going up
					  	else
							if ( ball_yrate < 2 ) then
								ball_yrate <= ball_yrate + 1;
							else
								ball_yrate <= 2;
							end if;
						end if;

					-- lower portion of paddle
					elsif  ( ( ball_y >= left_y + paddle_heightb) and ( ball_y <= left_y + paddle_heightc) ) then
						ball_xdir <= '1';
						-- if ball is going down
						if ( ball_ydir = '0' ) then 
							if ( ball_yrate < 2 ) then
								ball_yrate <= ball_yrate + 1;
							else
								ball_yrate <= 2;
							end if;
						-- if ball is going up
					  	else
							if ( ball_yrate > 0 ) then
								ball_yrate <= ball_yrate - 1;
							else
								ball_ydir <= '0';
								ball_yrate <= 1;
							end if;
						end if;				
					elsif (( ball_y >= left_y + paddle_heighta) and ( ball_y < left_y + paddle_heightb)) then
						ball_xdir <= '1';				
					end if;

				-- Score for right team
				else
					if ( ball_x = left_wall ) then	
						ball_xdir <= '1';		
						if ( enable = '1' ) then
							if ( rscore = 9 ) then
								rscore <= 0;
							else
								rscore <= rscore + 1;
							end if;
						end if;
					enable <= '0';
					end if;
				end if;
			end if;

			-- Vertical Movement ( 1 = up )
			if ( ball_ydir = '1' ) then
				if (ball_y <= wall_top) then
					ball_ydir <= '0';
				else
					ball_y <= ball_y - ball_yrate;
				end if;
			else 
				if (ball_y >= wall_bottom) then
					ball_ydir <= '1';
				else
					ball_y <= ball_y + ball_yrate;
				end if;
			end if;
	  else 
	  		delay <= delay + '1';
			ball_y <= ball_y;
			ball_yrate <= ball_yrate;
			ball_x <= ball_x;
			ball_ydir <= ball_ydir;
			ball_xdir <= ball_xdir;
	  end if;
  end if;
end process;

end static_display;