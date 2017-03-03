module Project1_top(input [1:0]buttons, input [9:0]switches, input clock, output reg [9:0]LEDs, output [6:0]SS0, output [6:0]SS1, output [6:0]SS2, output [6:0]SS3, output [6:0]SS4, output [6:0]SS5);
	wire [7:0] num1, num2, ao, lo, co;
	reg [1:0] mode;
	wire [1:0] operation;
	wire [9:0] magic;
	
	assign operation = switches[9:8];
	
	// set up debounced buttons
	wire button0, button1;
	Debouncer b0(clock, ~buttons[0], button0);
	Debouncer b1(clock, ~buttons[1], button1);
	
	// set up wires that can be used to dim LEDs
	wire dimX2, dimX4;
	DimmerX2 dX2(clock, dimX2);
	DimmerX4 dX4(clock, dimX4);
	
	// set up wire that can be used to recognize button presses
	wire button_press;
	assign button_press = button0 | button1;
	
	// set up 1hx and 10hz clock (using 10Mhz input)
	wire clk10hz, clk1hz;
	Clock1hz c1(clock, clk1hz);
	Clock10hz c10(clock, clk10hz);
	
	// set up modules
	Magic m(clk10hz, magic);
	Arithmetic a(operation, switches[7:0], ao, carry);
   Logical l(operation, switches[7:0], lo);
	Comparison c(operation, switches[7:4], switches[3:0], co);
	
	// set up multiplexer
	Multiplexer M(mode, ao, lo, co, 0, num1);
	
	// switch mode on button press
	always @ (posedge button_press) begin
		if (button1==1) begin
			mode = mode - 1;
		end else begin
			mode = mode + 1;
		end
	end
	
	// assign magic to lights 8-0
	always @ (magic[9:0]) begin
		// for most of them, turn the light on full if it's "lit" but turn it on half if one next to it is lot
		integer i;
		for (i = 2; i <= 7; i = i + 1) begin
			LEDs[i] = (mode[1]&mode[0]) & (magic[i] | ((magic[i+1] | magic[i+2] | magic[i-1] | magic[i-2]) & dimX2)); 
		end
		// special cases on the edge where i-1 or i+1 don't exist
		LEDs[8] = (mode[1]&mode[0]) & (magic[8] | ((magic[9] | magic[7] | magic[6]) & dimX2)); 
		LEDs[1] = (mode[1]&mode[0]) & (magic[1] | ((magic[2] | magic[3] | magic[0]) & dimX2)); 
		LEDs[0] = (mode[1]&mode[0]) & (magic[0] | ((magic[1] | magic[2]) & dimX2)); 
	end
	
	// assign magic / carry bit to light 9
	always @ (magic[9] or carry) begin
		LEDs[9] = ((mode[0]&mode[1]) & (magic[9] | ((magic[8] | magic[7]) & dimX2))) | ((~(mode[0]|mode[1])) & carry);
	end
	
	// assign digit 0 to be the first number
	SevenSegment I0(switches[7:4], SS0);
	// assign digit 1 to be the second number
	SevenSegment I1(switches[3:0], SS1);
	// assign digit 2 to be the mode
	SevenSegment I2(mode, SS2);
	// assign digit 3 to be the operation within the mode
	SevenSegment I3(operation, SS3);
	// assign digit 4 to be the first digit of the result, or the minus sign if it's a negative number
	SevenSegment O0(num1[7:4], SS4);
	// assign digit 5 to be the second digit of the result
	SevenSegment O1(num1[3:0], SS5);
endmodule 