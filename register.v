`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:36 11/16/2011 
// Design Name: 
// Module Name:    register 
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
module register # (parameter N = 8)
	(input clk,
	 input [N-1:0] in,
    output reg [N-1:0] out,
    input load,
    input clear
    );
	 
	 always @ (posedge clk or posedge clear)
		if (clear)		out <= 0;
		else if (load)	out <= in;
		else				out <= in;

endmodule

module register_hl # (parameter N = 16)
	(input clk,
	 input [N/2-1:0] inh,
	 input [N/2-1:0] inl,
	 input loadh,
	 input loadl,
	 input clear,
	 output reg [N-1:0] out
	);
	
	 always @ (posedge clk or posedge clear)
		if (clear)			out <= 0;
		else begin 
			if (loadh)	out[N-1:N/2] <= inh;
			if (loadl)	out[N/2-1:0] <= inl;
		end

	
endmodule