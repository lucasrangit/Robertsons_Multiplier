`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:56 11/16/2011 
// Design Name: 
// Module Name:    shift_register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module right_shift_register(clk, enable, in, mode, out);
    parameter width = 16;
    input clk;
    input enable;
    input [width-1:0] in; // input to shift
    input mode; // arithmetic (0) or logical (1) shift
    output [width-1:0] out; // shifted input

	reg [width-1:0] sr_out;
	
	always@(posedge clk)
	begin
		if (enable == 1'b1)
		begin
			sr_out[width-2:0] <= in[width-1:1];
			if (mode == 1'b1) // logical
				 sr_out[width-1] <= 1'b0;
			else // arithmetic
				 sr_out[width-1] <= in[width-1];
		end
	end
	
	assign out = sr_out;
/*
	if (enable == 1'b1)
	begin
		assign out[width-2:0] = in[width-1:1];
		if (mode == 1'b1) // logical
			assign out[width-1] = 1'b0;
		else // arithmetic
			assign out[width-1] = out[width-2];
	end
	else
		assign out = in;
*/
endmodule
