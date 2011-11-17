`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:13:33 11/16/2011
// Design Name:   right_shift_register
// Module Name:   /home/ECONOLITE/lmagasweran/Documents/personal/School/EE412/Robertsons_Multiplier/right_shift_register_test.v
// Project Name:  Robertsons_Multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: right_shift_register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module right_shift_register_test;

	// Inputs
	reg clk;
	reg enable;
	reg [15:0] in;
	reg mode;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	right_shift_register uut (
		.clk(clk), 
		.enable(enable), 
		.in(in), 
		.mode(mode), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		enable = 0;
		in = 0;
		mode = 0;
        
		// Add stimulus here
		enable = 0;
		mode = 1;
		in = 16'b1001011010010110;
	end
    
    // generate clock to sequence tests
    always
        begin
            clk <= 1; # 5; clk <= 0; # 5;
        end
      
endmodule

