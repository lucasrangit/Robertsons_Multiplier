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
