module Logical(input [1:0] mode, input [7:0] i, output [7:0] o);
	Multiplexer m(mode, 
		i[3:0] & i[7:4], 
		i[3:0] | i[7:4],
		i[3:0] ^ i[7:4], 
		~i, o);
endmodule
