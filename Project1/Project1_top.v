module Project1_top(input [1:0]buttons, input [9:0]switches, input clock, output [9:0]LEDs, output [6:0]Hex1In, output [6:0]Hex2In, output [6:0]Hex3In, output [6:0]Hex4In);
	wire [7:0] num1, num2;
	wire [7:0] ao, lo, co, mo;
	SevenSegment Mode(switches[9:8], Hex4In);
	assign Hex3In = 7'b1111111; // turn it off for now
	SevenSegment Hex1(num1[7:4], Hex2In); // placeholder
	SevenSegment Hex2(num1[3:0], Hex1In); // placeholder
	Arithmetic a(switches[9:8], switches[7:0], ao, LEDs[9]);
   Logical l(switches[9:8], switches[7:0], lo);
	Comparison c(switches[9:8], switches[7:4], switches[3:0], co);
	Multiplexer M(buttons, mo, co, lo, ao, num1);
endmodule 