module BCD_Counter(input clk, input clr, output reg [3:0]num, output reg reset);
	always @ (posedge clk) begin
		if (clr == 1) begin
			num = 0;
			reset = 1;
		end else if (num == 9) begin
			num = 0;
			reset = 1;
		end else begin
			num = num + 1;
			reset = 0;
		end
	end
endmodule
