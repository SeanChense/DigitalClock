////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2005 Xilinx, Inc.
// All Right Reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 8.1i
//  \   \         Application : ISE
//  /   /         Filename : ps2_cntrl.v
// /___/   /\     Timestamp : 9/20/2005 11:12:50
// \   \  /  \ 
//  \___\/\___\ 
//
//
//Design Name: PONG
//
// This module receives the Clock and serial data input from the PS2 port and outputs 
// a Scan Code representing the key entered on the keyboard 
//
module PS2_CTRL (
  Clk,
  Reset,
  PS2_Clk,
  PS2_Data,
  Scan_Code,
  scan_ready, 
  trigger,     
  DoRead
  );


// I/O declarations
input Clk;
input Reset;
input  PS2_Clk;				 // Clock input from PS2 port (~20-30 KHz)
input  PS2_Data;				 // Data input from PS2 port
output [7:0] Scan_Code;		 // Scan code representing keyboard key received
output scan_ready;			 // Signal indicating that a new Scan Code has been received
output trigger;				 // Trigger resets the read signal
input DoRead;					 // Signifies that read_ps2 is ready to receive another scan code


reg [7:0] Scan_Code;
reg scan_ready;
reg [8:0] s_reg;
reg [2:0] clk_low_filter;
reg [2:0] clk_high_filter;
reg filter_clk_en;
reg scan_en;
reg trigger;

reg [1:0] clear_reg;
reg [3:0] bit_count;
reg [1:0] scan_state;

parameter idle = 2'b00;
parameter shifting = 2'b11;


// Filtering PS2_Clk  --- Clk runs at ~ 50 Mhz  --- PS2_clk runs at ~ 20-30 KHz
always @(posedge Clk or posedge Reset)begin 
	if (Reset) begin
		clk_low_filter <= 3'b000;
		clk_high_filter <= 3'b000;
		filter_clk_en <= 1'b0;
	  	end
	else begin
		if (PS2_Clk)	begin
		   scan_en <= 1'b0;
		   filter_clk_en <= 1'b0;
			clk_low_filter <= 3'b000;
			clk_high_filter <= clk_high_filter + 3'b001;
			if (clk_high_filter == 3'b011)
				filter_clk_en <= 1'b1;	//If PS2_Clk remains high for 7 CLK cycles, enable filter_clk, scan_en transitions high
				scan_en <= 1'b1;
		end
		else if (!PS2_Clk) begin
		   filter_clk_en <= 1'b0;
			clk_high_filter <= 3'b000;
			clk_low_filter <= clk_low_filter + 3'b001;
			if (clk_low_filter == 3'b011)
				filter_clk_en <= 1'b1;	//If PS2_Clk remains low for 7 CLK cycles, enable filter_clk, scan_en transitions low
				scan_en <= 1'b0;
		end
	end		
end

always @(posedge Clk or posedge Reset)	begin
	if (Reset) begin
		Scan_Code <= 8'b00000000;	 // No scan code received
		clear_reg <= 2'b00;
		scan_ready <=	1'b0;
	end
	else begin
		if ((trigger) && (DoRead) && (scan_en)) begin   
				Scan_Code <= s_reg[7:0];	   //Scan_Code gets the shifted in value of PS2_Data 
				clear_reg <= 2'b00;
				scan_ready <=	1'b1;				//New scan code has been received
		end
		else begin
			clear_reg <= clear_reg + 2'b01;	 //wait two clock cycles before clearing scan_ready
			if (clear_reg >= 2'b10) begin
				clear_reg <= 2'b00;
				scan_ready <=	1'b0;
			end
		end		
	end
end	
			
			 

// Scan_State transition logic 
always @(posedge Clk or posedge Reset)
begin : scan_state_logic
	if (Reset) begin
		bit_count <= 4'b0000;
		scan_state <= idle;
		s_reg = 9'b000000000;
		end
	else if (scan_en && filter_clk_en)
  	case (scan_state)
		idle: begin							// Waiting to receive data input from PS2 port
			s_reg = 9'b000000000;
			bit_count <= 4'b0000;
			trigger <= 1'b0;
			if (!PS2_Data) begin			// start bit received
				scan_state <= shifting;	// goto shifting state
			end	
			else scan_state <= idle;
		 end
	    shifting:			 				 // receiving data
          begin
				bit_count <= bit_count + 4'b0001;	  // number of bits received incremented
				s_reg = {PS2_Data,s_reg[8:1]};		  // PS2_Data bit shifeted into s_reg
            scan_state <= shifting;
				trigger <= 1'b0;
				if (bit_count == 4'b1000) begin		  // complete key code recieved
					trigger <= 1'b1;
				end
				if (bit_count >= 4'b1001) begin		  // stop bit recieved
						trigger <= 1'b0;
						scan_state <= idle;				  // goto idle state
				end
          end
	    default : scan_state <= idle;
  endcase
end

endmodule
