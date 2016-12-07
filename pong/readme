-- Copyright(C) 2009 by Xilinx, Inc. All rights reserved. 
-- The files included in this design directory contain proprietary, confidential information of 
-- Xilinx, Inc., are distributed under license from Xilinx, Inc., and may be used, copied 
-- and/or disclosed only pursuant to the terms of a valid license agreement with Xilinx, Inc. 
-- This copyright notice must be retained as part of this text at all times. 


Pong is a mixed schematic, VHDL, Verilog project featuring the PS2 and VGA monitor connections of 
the Xilinx\Digilent Spartan-3 demo board.

DESIGN TYPE: ISE (chip 3s200 FT256-4)
 
CONTROLS (Inputs):
	clk_ic4	- 50 MHz clock input from on-board oscillator,
	btn(3)	- left most push button on S-3 demo board used as reset for design
	ps2d		- data input from PS2 port
	ps2c		- clock input from PS2 port	
  
OUTPUTS:  
	seg_<a,b,c,d,e,f,g,dp> - 7-segment display for used to display game title,
	an(3:0)	- anode control to determine active seven segment display
	vga_red	- red color signal to VGA monitor
	vga_blue	- blue color signal to VGA monitor
	vga_green	- green color signal to VGA monitor
	vga_vs	- vertical synchronization signal to VGA monitor
	vga_hs	- horizontal synchronization signal to VGA monitor

DESCRIPTION: This simple design receives the input from a ps2 keyboard to control the paddles 
and serve for a pong game.  The game is displayed on a VGA monitor.  
The following keyboard keys are used as controls
	up arrow key - right paddle up
	down arrow key - right paddle down
	w key	- left paddle up
	s key - left paddle down
	space bar key - serve ball

Source Files:

pong_top.sch  -   The top level schematic contains symbolic layout of the pong design including 
					   the FPGA pin connections to many of the Spartan3 demo board input, display 
					   and port features. 

pong_cntrl.vhd  - This Entity contains the pong game logic

testram.vhd  - 	This Entity contains an array of data elements representing VGA display patterns

vgacore_multi.vhd  -  This Entity contains the VGA display control. 

game_title.v  -   This module displays the title, PONG, on the four seven segment LEDs of the 
					   Spartan3 Demo Board

read_ps2.v  -   	This module interprets the scan code from the keyboard and outputs the 
					   corresponding signal to move a paddle or serve. 

ps2_cntrl.v  -   	This module receives the Clock and serial data input from the PS2 port and 
					   outputs a Scan Code representing the key entered on the keyboard 

vga_interface.vhd  -  This Entity interprets the color output to the VGA monitor



Behavioral and RTL Simulation done using Test bench, pong_tb.v. 
  

NOTE: If you are trying to run this example in a read-only location, the design hierarchy will 
		not display properly.  Please copy the example project to a new location by using either 
		Project Save As... from the File menu pulldown in ISE or some other method of your choice.  
		Copy the example to a location where you have write permissions and the hierarchy will 
		display properly. 

  
For support information and contacts please see: 
  
	http://www.xilinx.com/support
or 
	http://www.xilinx.com/support/services/contact_info.htm
