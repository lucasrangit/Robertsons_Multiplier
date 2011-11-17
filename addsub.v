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
