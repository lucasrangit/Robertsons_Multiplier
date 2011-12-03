`timescale 1ns / 1ps
// Implementation of Robertson's multiplier using a FSM control unit and 
// datapath to meet the requirements outlined in toprobertsons.v.
module robsmult #(parameter WIDTH = 8)
    (
    input clk,
    input reset,
    input [WIDTH-1:0] multiplier,
    input [WIDTH-1:0] multiplicand,
    output [WIDTH*2-1:0] product, // multiplier * multiplicand 
	output done // signal that product is ready
    );
	 
	// control signals
	wire c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11;
	
	// datapath signals
	wire zq, zy, zr;

	// instantiate control unit
	control_unit cu(clk, reset, zq, zy, zr, c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11, done);
	
	// instantiate datapath
	datapath dp(clk, reset, multiplier, multiplicand, c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11, product, zq, zr);
	
	assign zy = ~multiplicand[WIDTH-1];
	
endmodule

// this control unit implements the FSM required to control the datapath
// needed by a Robertson's multiplier described in toprobertsons.v.
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
	parameter   S6 	    = 5'b00110;	// State 06
	parameter   S7 	    = 5'b00111;	// State 07
	parameter   S8   	= 5'b01000;	// State 08
	parameter   S9 	    = 5'b01001;	// State 09
	parameter   S10	    = 5'b01010;	// state 0a
	parameter   S11     = 5'b01011;	// State 0b
	parameter   S12 	= 5'b01100; // State 0c
	parameter   S13 	= 5'b01101; // State 0d
	parameter   S14  	= 5'b01111;	// State 0f
	parameter   S15	    = 5'b10010;	// State 12
	parameter   S16	    = 5'b10011;	// State 13
	parameter   S17	    = 5'b10100;	// State 14

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
		S14:  nextstate <= S15;
		S15:  nextstate <= S16;
		S16:  nextstate <= S17;
		S17:  begin nextstate <= S17; done <= 1; end
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
		S10:    	controls <= 15'b010_0011_0101_0000;
		S11:  		controls <= 15'b000_0000_0000_0000;
		S12:        controls <= 15'b000_0000_0000_0000;   
		S13:       	controls <= 15'b000_0001_0010_0000;
		S14:        controls <= 15'b001_0000_0000_0000;
		S15:        controls <= 15'b000_0011_0101_0000;
		S16:        controls <= 15'b100_0000_1000_1000;	
		S17:        controls <= 15'b000_0000_0000_0000;	
		default:    controls <= 15'b000_0000_0000_0000; // should never happen
	 endcase
	 
endmodule

// this datapath implements hardware required to perform signed
// Robertson's multiplication described in toprobertsons.v.
module datapath #(parameter WIDTH = 8)
    (
	input clk, reset,
	input [WIDTH-1:0] multiplier, multiplicand,
	input c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11,
	output [WIDTH*2-1:0] product,
	output zq, zr
	);
	
	// Internal signals of the datapath module
	wire [WIDTH-1:0] y, a, in_x, x, in_rh, in_rl, alu_out, q;
	wire [WIDTH*2-1:0] r, sr;
	
	register reg_y(clk, multiplicand, y, c0, 1'b0);
	register reg_a(clk, r[WIDTH*2-1:WIDTH], a, c14, c2);
	register reg_x(clk, in_x, x, c3, 1'b0);
	register_hl reg_r(clk, in_rh, in_rl, c8, c9, 1'b0, r);
	
	right_shift_register sign_ext(clk, c12, r, c11, sr); 
	
	mux2 #(8) mux_x(multiplier, r[WIDTH-1:0], c7, in_x);
	mux3 #(8) mux_rh(a, sr[WIDTH*2-1:WIDTH], alu_out, {c5,c4}, in_rh);
	mux2 #(8) mux_rl(x, sr[WIDTH-1:0], c6, in_rl);
	
	addsub addsub(r[WIDTH*2-1:WIDTH], y, c10, clk, alu_out);
	
	counter_down decrement8(clk, c1, c13, q);
	
	// External: signals to control unit and outbus
	assign product = {a,x};
	assign zr = ~r[0];
	assign zq = ~q[0] & ~q[1] & ~q[2]; // zq = 1 when q = 0 (3'b000) from 7 (3'b111)
	
endmodule
