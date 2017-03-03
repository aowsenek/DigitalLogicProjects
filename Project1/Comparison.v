module Comparison(input [1:0] mode, input [3:0]x, input [3:0]y, output [3:0]o);
	wire yg, xg;
	wire [3:0] max;
	less_than lt1(x, y, yg);
	less_than lt2(y, x, xg);
	Multiplexer m1(xg, y, x, 0, 0, max); // last two not used
	Multiplexer m2(mode, ~(xg|yg), xg, yg, max, o);
endmodule

module less_than(input [3:0]x, input[3:0]y, output o);
	reg [4:0] g;
	integer i;
	always @ (x or y) begin
		for (i = 0; i < 4; i = i + 1) begin
			g[i+1] = ((~(x[i]^y[i]))&g[i])|((x[i]^y[i])&y[i]);
		end
		g[0] = 0;
	end
	assign o = g[4];
endmodule
