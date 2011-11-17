`timescale 1ns / 1ps


	// Outputs
	wire [15:0] product;
	wire done;
    
    // keep track of execution status
    reg  [31:0] cycle;
    
    // expected results
	reg [15:0] expected_product;

	// Instantiate the Unit Under Test (UUT)
	toprobertsons uut (
		.clk(clk), 
		.reset(reset), 
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:58:48 11/16/2011
// Design Name:   toprobertsons
// Module Name:   /home/ECONOLITE/lmagasweran/Documents/personal/School/EE412/Robertsons_Multiplier/robertsonstest.v
// Project Name:  Robertsons_Multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: toprobertsons
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module robertsonstest;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] multiplier;
	reg [7:0] multiplicand;
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.product(product),
		.done(done)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		multiplier = 0;
		multiplicand = 0;
		expected_product = 0;
        
		// Add stimulus here
      reset <= 1; # 12; reset <= 0;
		cycle <= 1;
		// 1.1 Positive Multiplicand and Positive Multiplier
		multiplier = 5;
		multiplicand = 6;
		expected_product = 30;
        // 1.2 Positive Multiplicand and Positive Multiplier
		//multiplier = 7;
		//multiplicand = 5;
		//expected_product = 35;
		// 2.1 Negative Multiplicand and Positive Multiplier
		//multiplier = 5;
		//multiplicand = -6;
		//expected_product = -30;
        // 2.2 Negative Multiplicand and Positive Multiplier
		//multiplier = 7;
		//multiplicand = -5;
		//expected_product = -35;
		// 3.1 Positive Multiplicand and Negative Multiplier
		//multiplier = -5;
		//multiplicand = 6;
		//expected_product = -30;
        // 3.2 Positive Multiplicand and Negative Multiplier
		//multiplier = -7;
		//multiplicand = 8;
		//expected_product = -56;
		// 4.1 Negative Multiplicand and Negative Multiplier
		//multiplier = -5;
		//multiplicand = -6;
		//expected_product = 30;
        // 4.2 Negative Multiplicand and Negative Multiplier
		//multiplier = -9;
		//multiplicand = -4;
		//expected_product = 36;
	end
      
    // generate clock to sequence tests
    always
        begin
            clk <= 1; # 5; clk <= 0; # 5;
            cycle <= cycle + 1;
        end
        
    // check results
    // If successful, it should write the value 7 to address 84
    always@(negedge clk)
    begin
      if (done) begin
        if (product == expected_product) begin
            $display("Simulation succeeded");
            $stop;
        end else begin
            $display("Simulation failed");
            $stop;
        end
      end
    end
   
endmodule

