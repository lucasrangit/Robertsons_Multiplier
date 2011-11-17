`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        California State University, Fullerton
// Engineer:       Lucas Magasweran, Alan Nguyen
// 
// Create Date:    17:31:25 11/16/2011 
// Design Name:    8x8 Robertson's Multiplier 
// Module Name:    toprobertsons 
// Project Name:   EE557 Homework #4
// Target Devices: Simululator (xc3sd1800a-4fg676)
// Tool versions:  Xilinx ISE 13.1
// Description: 
// This multiplier implements the Robertson's algorithm (that was discussed 
// in class) for the multiplication of two signed binary numbers in 2's 
// complement format. In your design, the multiplicand must be placed in a 
// register called Y. Two more registers, A and X, must also be used in your 
// design. The register A is initially loaded with all 0s and the register X is 
// initially loaded with the multiplier. A and X, combined, acts as a shift 
// register (A:X). You may use additional hardware structures as necessary to 
// complete your design. The final product must be stored in the shift register
//  A:X.
// Dependencies: none.
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
