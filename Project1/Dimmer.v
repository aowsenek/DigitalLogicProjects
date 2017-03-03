module DimmerX2(input clk, output o);
	parameter n = 4;
	reg [n:0]arr;
	assign o = arr[0];
	initial begin
		arr = 3;
	end
	always @ (posedge clk) begin
		arr[n:1] = arr[n-1:0];
		arr[0] = arr[n];
	end
endmodule

module DimmerX4(input clk, output o);
	parameter n = 4;
	reg [n:0]arr;
	assign o = arr[0];
	initial begin
		arr = 1;
	end
	always @ (posedge clk) begin
		arr[n:1] = arr[n-1:0];
		arr[0] = arr[n];
	end
endmodule
