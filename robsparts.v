// Asynchronous load and store register
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
		else			out <= in;

endmodule

// Asynchronous load and store register with signals to control 
// high and low bits seperately or at the same time
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

// micro-PC, asynchronous reset
// Active high load
// Active low increment
module upcreg(
    input clk,
    input reset,
    input load_incr,
    input [4:0] upc_next,
    output reg [4:0] upc);

    always @ (posedge clk, posedge reset)
        if (reset)  upc <= 5'b00000;
        else if (load_incr) upc <= upc_next;
        else if (~load_incr) upc <= upc + 1;
        else upc <= 5'b00000; //should never get here

endmodule     
      
// 5:1 MULTIPLEXER
module mux5 (input      d0, d1, d2, d3, d4,
              input      [2:0]       s, 
              output reg  y);

   always @( * )
      case(s)
         3'b000: y <= d0;
         3'b001: y <= d1;
         3'b010: y <= d2;
         3'b011: y <= d3;
         3'b100: y <= d4;
         default: y <= 1'b0;
      endcase
endmodule

// 8-bit Adder/Subtractor (active low subtract)
module addsub
(
	input [7:0] dataa,
	input [7:0] datab,
	input add_sub,	  // if this is 1, add; else subtract
	input clk,
	output reg [7:0] result
);

	always @ (*)
	begin
		if (add_sub)
			result <= dataa + datab;
		else
			result <= dataa - datab;
	end

endmodule

// Counter that decrements from WIDTH to 0 at every positive clock edge.
module counter_down
(
	clk,
	reset,
	ena,
	result
);

	input clk;
	input reset;
	input ena;
	output reg [7:0] result;

	always @(posedge clk or posedge reset)
	begin
		if (reset) 
			result = 7;		
		else if (ena) 
			result = result - 1;
	end
endmodule		
