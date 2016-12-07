////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2005 Xilinx, Inc.
// All Right Reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 8.1i
//  \   \         Application : 
//  /   /         Filename : game_title.v
// /___/   /\     Timestamp : 09/20/2005 11:01:05
// \   \  /  \ 
//  \___\/\___\ 
//
// This module displays the title, PONG, on the four seven segment LEDs of the Spartan3 Demo Board

`timescale 1ns / 1ps

module game_title(clk, 
                  an, 
                  seven_seg);

    input clk;
   output [3:0] an;
   output [7:0] seven_seg;
   
	reg [9:0] cnt;
   reg [3:0] an;
   reg [7:0] seven_seg = 8'b00110001;


always @(posedge clk) begin
	case (cnt[9:8])	// The clock for determining display element must be slow enough 
							// to allow RC values to settle.
		
		2'b00 : begin
			an <= 4'b0111;							//1st element
			seven_seg <= 8'b00110001;		  	// 7-seg letter P
			end

		2'b01 : begin
			an <= 4'b1011;							//2nd element
			seven_seg <= 8'b00000011;		  	// 7-seg letter O
			end
 
		2'b10 : begin
			an <= 4'b1101;							// 3rd element
			seven_seg <= 8'b00010011;			// 7-seg letter n
			end

		2'b11 : begin
			an <= 4'b1110;							// 4th element
			seven_seg <= 8'b00001001;			// 7-seg letter g
			end

		default : begin
         an <= 4'b0111;							//1st element
			seven_seg <= 8'b00110001;		  	// 7-seg letter P
         end

	 endcase
	end   

always @(posedge clk) begin
	cnt <= cnt + 1;
	end
endmodule
