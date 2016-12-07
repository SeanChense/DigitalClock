////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2005 Xilinx, Inc.
// All Right Reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 8.1i
//  \   \         Application : ISE
//  /   /         Filename : read_ps2
// /___/   /\     Timestamp : 09/20/2005 11:12:50
// \   \  /  \ 
//  \___\/\___\ 
//
//
//Design Name: PONG
//
// This module interprets the scan code from the keyboard and outputs the  
// corresponding signal to move a paddle or serve. 


`timescale 1ns / 1ps

module read_ps2(Clk, 
                PS2_Clk, 
                PS2_Data, 
                Reset,
					 ps2_code, 
                left_dir, 
                right_dir,
					 serve
					 );

	 input Clk;
    input PS2_Clk;
    input PS2_Data;
    input Reset;
   output [1:0] left_dir;
   output [1:0] right_dir;
   output [7:0] ps2_code; 
	output serve;

   	reg [1:0] left_dir = 2'b00;
   	reg [1:0] right_dir = 2'b00;
		reg serve;
 	  	reg read;   
	 	wire data_ready;
		reg stopkey;
		reg state;
		wire trigger;


  PS2_CTRL ps2_ctrl ( 
	.Clk(Clk),
	.DoRead(read),
	.PS2_Clk(PS2_Clk),
	.PS2_Data(PS2_Data),
	.Reset(Reset),
	.Scan_Code(ps2_code),
	.scan_ready(data_ready),
	.trigger(trigger)
	);



   always @(posedge Clk or posedge Reset)

      if (Reset) begin
		  	right_dir <= 2'b00;						  // No right paddle movement
		  	left_dir <= 2'b00;						  // No left paddle movement
			serve <= 1'b1;								  // Start with ball being served
			read = 1'b1;								  // Ready to receive scan code
			stopkey <= 1'b0;							  // Stop key code has not been read
			state <= 2'b0;
      end

      else if ((data_ready) | (!read)) begin		 // New key data has arrived
			case (state)
				1'b0 : begin
					if (!stopkey) begin			 // new data is not releasing a key
						case (ps2_code)
			  	   		8'b01110101: begin	  				   // up arrow key
							       right_dir <= 2'b01;	  			//right up
			                end
			      		8'b01110010: begin						// down arrow key
			                   right_dir <= 2'b10;	  			// right down
			                end
			      		8'b00011101: begin					   // w key	
			                   left_dir <= 2'b01;				//	left up
			                end
			      		8'b00011011: begin						// s key
			                   left_dir <= 2'b10;				// left down
			                end
			      		8'b00101001: begin						// space bar key
			                   serve <= 1'b1;					// serve ball
			                end
							8'b11110000: begin						// A key has been released
			                  stopkey <= 1'b1;	  				// set stopkey bit 
			          			serve <= "0";					
			                end
			      		default: begin
									right_dir <= right_dir;	  
			                  left_dir <= left_dir;
									serve <= "0";
			               end
						endcase  		   	  // end of case (ps2_code) statement
					  state <= 1'b1;
					end
					else begin	 				  // new data is telling which key was just released
						case (ps2_code)
			  	   		8'b01110101: begin	  				   // up arrow key
							    if (right_dir == 2'b01)
									right_dir <= 2'b00;				// stop right paddle up	motion
								 stopkey <= 1'b0;
			                end
			      		8'b01110010: begin						// down arrow key
			                if (right_dir == 2'b10)   
									 right_dir <= 2'b00;	  			// stop right paddle down motion
									 stopkey <= 1'b0;
			                end
			      		8'b00011101: begin					   // w key	
			                if (left_dir == 2'b01)   
									 left_dir <= 2'b00;				//	stop left paddle up motion
									 stopkey <= 1'b0;
			                end
			      		8'b00011011: begin						// s key
			                if (left_dir == 2'b10)   
									 left_dir <= 2'b00;				// stop left paddle down motion
									 stopkey <= 1'b0;
			                end
							8'b11100000: begin						// Extended code key
			                   stopkey <= 1'b1;			   	// Check next ps2 entry for stop											 
			                end
			      		8'b00101001: begin						// space bar key
			                   serve <= 1'b0;					// stop serve ball
									 stopkey <= 1'b0;
			                end
			      		default: begin
							end 				
				  	   endcase 									      // end of case (ps2_code) statement
						state <= 1'b1;
					end 
					read = 1'b0;
				end

				1'b1 : begin
					if (!trigger) begin 
						read = 1'b1;									// resets read bit to enable PS2_Ctrl input
				 		state <= 1'b0;
					end
				end				
			endcase
		end	// End of if (read_data) statement
endmodule