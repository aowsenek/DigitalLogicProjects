module BCD_Counter(input clk, output reg [3:0]num, output reg reset);
	always @ (posedge clk) begin
		if (num == 9) begin
			num = 0;
			reset = 1;
		end else begin
			num = num + 1;
			reset = 0;
		end
	end
endmodule
