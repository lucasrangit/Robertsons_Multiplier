`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:25 11/16/2011 
// Design Name: 
// Module Name:    toprobertsons 
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
module toprobertsons(
    input       clk, reset, 
    input [7:0] multiplier, // 8-bit data input to multiplier unit
    input [7:0] multiplicand, // 8-bit data input to multiplier unit
    output [15:0] product, // 16-bit data output of multiplier unit
	 output done // flag to signal multiplication is complete to testbench
    );

	// instantiate Robertson's Multiplier
	robsmult mult(clk, reset, multiplier, multiplicand, product, done);
    
    // instantiate signed multipler (used for testing testbench)
    //signed_mult mult(product, clk, multiplier, multiplicand);

endmodule
