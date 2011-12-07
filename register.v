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
      