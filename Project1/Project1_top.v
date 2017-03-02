module Project1_top(input [1:0]buttons, input [9:0]switches, input clock, output [9:0]LEDs, output [6:0]SS0, output [6:0]SS1, output [6:0]SS2, output [6:0]SS3, output [6:0]SS4, output [6:0]SS5);
	wire [7:0] num1, num2;
	wire [7:0] ao, lo, co, mo;
	SevenSegment I0(switches[7:4], SS0);
	SevenSegment I1(switches[3:0], SS1);
	SevenSegment I2(buttons, SS2);
//	assign SS2 = 7'b1111111;
	assign SS3 = 7'b1111111;
	SevenSegment O0(num1[7:4], SS4);
	SevenSegment O1(num1[3:0], SS5);
	Arithmetic a(switches[9:8], switches[7:0], ao, LEDs[9]);
   Logical l(switches[9:8], switches[7:0], lo);
	Comparison c(switches[9:8], switches[7:4], switches[3:0], co);
	Multiplexer M(buttons, mo, co, lo, ao, num1);
endmodule 