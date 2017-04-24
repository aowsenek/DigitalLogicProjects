//http://rijndael.ece.vt.edu/schaum//teaching/ddii/lecture6.pdf
module LFSR_generator(input clock, input rst, input seed, input load, output q);
wire [3:0] s_out;
wire [3:0] s_in;
wire nextbit;

flipflop F[3:0] (clock, rst, s_in, s_out);
mux2to1 m1[3:0](seed, {s_out[2],s_out[1],s_out[0],nextbit},load,s_in);

xor G1(nextbit, s_out[2], s_out[3]);

assign q = nextbit;

endmodule

//q clk rst d
module flipflop(input clock, input rst, input d, output reg q);
always @(posedge clock or posedge rst)
begin
	if(rst)
	q=0;
	else
	q=d;
end
endmodule

//q control a b
module mux2to1(input a, input b, input s, output reg m);

always @(s or a or b)
m = (s&a | !s&b);
endmodule

