module Multiplexer(input [1:0] mode, input [7:0]i0, input [7:0]i1, input [7:0]i2, input [7:0]i3, output reg [7:0]o);
always @ (mode or i0 or i1 or i2 or i3)
case (mode)
	0: o = i0;
	1: o = i1;
	2: o = i2;
	3: o = i3;
endcase
endmodule