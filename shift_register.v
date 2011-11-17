// Right shift register with an arithmetic or logical shift mode
module right_shift_register(clk, enable, in, mode, out);
    parameter width = 16;
    input clk;
    input enable;
    input [width-1:0] in; // input to shift
    input mode; // arithmetic (0) or logical (1) shift
    output [width-1:0] out; // shifted input

	reg [width-1:0] sr_out;
	
	always@(posedge clk)
	begin
		if (enable == 1'b1)
		begin
			sr_out[width-2:0] <= in[width-1:1];
			if (mode == 1'b1) // logical
				 sr_out[width-1] <= 1'b0;
			else // arithmetic
				 sr_out[width-1] <= in[width-1];
		end
	end
	
	assign out = sr_out;

endmodule
