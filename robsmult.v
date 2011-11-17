`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:03 11/16/2011 
// Design Name: 
// Module Name:    robsmult 
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
module robsmult(
    input clk,
    input reset,
    input [7:0] multiplier,
    input [7:0] multiplicand,
    output [15:0] product,
	 output done
    );
	 
	// control signals
	wire c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11;
	
	// datapath signals
	wire zq, zy, zr;

	// instantiate control unit
	control_unit cu(clk, reset, zq, zy, zr, c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11, done);
	
	// instantiate datapath
	datapath dp(clk, reset, multiplier, multiplicand, c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11, product, zq, zr);
	
	assign zy = ~multiplicand[7];
	
endmodule

module control_unit(
	input clk, reset,
	input zq, zy, zr,
	output c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11,
	output reg done
	);
	
	// FSM States
	parameter   S0  	= 5'b00000; // State 00
	parameter   S1  	= 5'b00001; // State 01
	parameter   S2  	= 5'b00010;	// State 02
	parameter   S3   	= 5'b00011;	// State 03
	parameter   S4   	= 5'b00100;	// State 04
	parameter   S5   	= 5'b00101;	// State 05
	parameter   S6 	= 5'b00110;	// State 06
	parameter   S7 	= 5'b00111;	// State 07
	parameter   S8   	= 5'b01000;	// State 08
	parameter   S9 	= 5'b01001;	// State 09
	parameter   S10	= 5'b01010;	// state 0a
	parameter   S11   = 5'b01011;	// State 0b
	parameter   S12 	= 5'b01100; // State 0c
	parameter   S13 	= 5'b01101; // State 0d
	parameter   S14 	= 5'b01110;	// State 0e
	parameter   S15  	= 5'b01111;	// State 0f
	parameter   S16  	= 5'b10000;	// State 10
	parameter   S17  	= 5'b10001;	// State 11
	parameter   S18	= 5'b10010;	// State 12
	parameter   S19	= 5'b10011;	// State 13
	parameter   S20	= 5'b10100;	// State 14

	reg [4:0]  state, nextstate;
	reg [14:0] controls;	
	
	// state register
	always @(posedge clk or posedge reset)			
	 if (reset) state <= S0;
	 else state <= nextstate;
	 
	// next state logic
	always @( * )
	 case(state)
		S0:  nextstate <= S1;
		S1:  nextstate <= S2;
		S2:  nextstate <= S3;
		S3:  case(zq)
					  0:      nextstate <= S4;
					  1:      nextstate <= S12;
					  default: nextstate <= S0;  // should never happen
					endcase
		S4:  case(zr)
					  0:      nextstate <= S5;
					  1:      nextstate <= S6;
					  default: nextstate <= S0; // should never happen
					endcase
		S5:  nextstate <= S6;
		S6:  case(zy)
					  0:      nextstate <= S7;
					  1:      nextstate <= S9;
					  default: nextstate <= S0; // should never happen
					endcase
		S7:  nextstate <= S8;		
		S8:  nextstate <= S10;	
		S9:  nextstate <= S10;
		S10:  nextstate <= S11;
		S11:  nextstate <= S3;
		S12:  case(zr)
					  0:      nextstate <= S13;
					  1:      nextstate <= S14;
					  default: nextstate <= S0; // should never happen
					endcase
		S13:  nextstate <= S14;
		S14:  case(zy)
					  0:      nextstate <= S15;
					  1:      nextstate <= S17;
					  default: nextstate <= S0; // should never happen
					endcase
		S15:  nextstate <= S16;
		S16:  nextstate <= S18;
		S17:  nextstate <= S18;
		S18:  nextstate <= S19;
		S19:  nextstate <= S20;
		S20:  begin nextstate <= S20; done <= 1; end
	 endcase
	 
	// output logic
	assign {c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0} = controls;
	 
	always @( * )
	 case(state)
	   S0:        	controls <= 15'b000_0000_0000_0011;
		S1:       	controls <= 15'b000_0000_0000_1100;
		S2:         controls <= 15'b000_0011_0000_0000;
		S3:         controls <= 15'b000_0000_0000_0000;
		S4:         controls <= 15'b000_0000_0000_0000;
		S5:         controls <= 15'b000_0101_0010_0000;
		S6:         controls <= 15'b000_0000_0000_0000;
		S7:        	controls <= 15'b001_0000_0000_0000;
		S8:   		controls <= 15'b000_0000_0000_0000;
		S9:         controls <= 15'b001_1000_0000_0000;
		S10:    		controls <= 15'b010_0011_0101_0000;
		S11:  		controls <= 15'b000_0000_0000_0000;
		S12:        controls <= 15'b000_0000_0000_0000;   
		S13:       	controls <= 15'b000_0001_0010_0000;
		S14:        controls <= 15'b000_0000_0000_0000;
		S15:        controls <= 15'b001_0000_0000_0000;
		S16:        controls <= 15'b000_0000_0000_0000;
		S17:        controls <= 15'b001_0000_0000_0000;
		S18:        controls <= 15'b000_0011_0101_0000;
		S19:        controls <= 15'b100_0000_1000_1000;	
		S20:        controls <= 15'b000_0000_0000_0000;	
		default:    controls <= 15'b000_0000_0000_0000; // should never happen
	 endcase
	 
endmodule

module datapath(
	input clk, reset,
	input [7:0] multiplier, multiplicand,
	input c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11,
	output [15:0] product,
	output zq, zr
	);
	
	// Internal signals of the datapath module
	wire [7:0] y, a, in_x, x, in_rh, in_rl, alu_out, q;
	wire [15:0] r, sr;
	
	register reg_y(clk, multiplicand, y, c0, 1'b0);
	register reg_a(clk, r[15:8], a, c14, c2);
	register reg_x(clk, in_x, x, c3, 1'b0);
	register_hl reg_r(clk, in_rh, in_rl, c8, c9, 1'b0, r);
	
	right_shift_register sign_ext(clk, c12, r, c11, sr); 
	
	mux2 #(8) mux_x(multiplier, r[7:0], c7, in_x);
	mux3 #(8) mux_rh(a, sr[15:8], alu_out, {c5,c4}, in_rh);
	mux2 #(8) mux_rl(x, sr[7:0], c6, in_rl);
	
	addsub addsub(r[15:8], y, c10, clk, alu_out);
	
	counter_down decrement8(clk, c1, c13, q);
	
	// fields to controller
	assign product = {a,x};
	assign zr = ~r[0];
	assign zq = ~q[0] & ~q[1] & ~q[2]; // zq = 1 when q = 0 (3'b000) from 7 (3'b111)
	
endmodule

module mux2 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, 
              input              s, 
              output [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, d2,
              input  [1:0]       s, 
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule