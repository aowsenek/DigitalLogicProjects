module Project2_top(input [1:0]buttons, input [9:0]switches, input clock, output [9:0]LEDs, output [6:0]SS0, output [6:0]SS1, output [6:0]SS2, output [6:0]SS3, output [6:0]SS4, output [6:0]SS5);
	wire clk100hz;
	wire [3:0]highScore;
	wire [3:0]o;
	wire [3:0]d0, d1, d2, d3, d4, d5;
	wire t0, t1, t2, t3, t4, t5;
	Clock100hz c1(clock, clk100hz);
	/*BCD_Counter BCD0(clk100hz, d0, t0);
	BCD_Counter BCD1(t0, d1, t1);
	BCD_Counter BCD2(t1, d2, t2);
	BCD_Counter BCD3(t2, d3, t3);
	BCD_Counter BCD4(t3, d4, t4);
	BCD_Counter BCD5(t4, d5, t5);
	
	BCD_Decoder D5(d0, SS5);
	BCD_Decoder D4(d1, SS4);
	BCD_Decoder D3(d2, SS3);
	BCD_Decoder D2(d3, SS2);
	BCD_Decoder D1(d4, SS1);
	BCD_Decoder D0(d5, SS0);*/
	
	///clock, reset, seed, load, output
	LFSR_generator g1(c1, 0, 1010, 1, o[0]); //testing LSFR
	LFSR_generator g2(c1, 0, 1110, 1, o[1]); //testing LSFR
	LFSR_generator g3(c1, 0, 0110, 1, o[2]); //testing LSFR
	LFSR_generator g4(c1, 0, 1011, 1, o[3]); //testing LSFR
//	BCD_Decoder DG1(o, SS5);
	
//	assign SS0 = 7'b0111111;
//	assign SS1 = 7'b1011111;
//	assign SS2 = 7'b1101111;
//	assign SS3 = 7'b1110111;
//	assign SS4 = 7'b1111011;
//	assign SS5 = 7'b1111101;
endmodule 