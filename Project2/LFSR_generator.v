//http://rijndael.ece.vt.edu/schaum//teaching/ddii/lecture6.pdf
module LFSR_generator(input clock, input [3:0]seed, output [3:0]q);
	reg [4:0] r = 5'b00001;
	always @(posedge clock) begin
		r[4] = r[0]^r[1];
		r = r >> 1;
	end
	assign q = r[3:0];
endmodule
