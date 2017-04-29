module Project2_top(input [1:0]buttons, input [9:0]switches, input clock, output [9:0]LEDs, output [6:0]SS0, output [6:0]SS1, output [6:0]SS2, output [6:0]SS3, output [6:0]SS4, output [6:0]SS5);
	wire clk100hz, clk1hz, highScore, runButton, resetButton, r0, r1, r2;
	wire [3:0] rand, c0, c1, c2;
	wire [6:0] d0, d1, d2, hd0, hd1, hd2;
	
	// States:
	//   0: Inactive
	//   1: Waiting
	//   2: Counting
	//   3: Displaying
	reg [1:0] state = 0;
	reg [3:0] timer, readyTime, h0 = 4'b1001, h1 = 4'b1001, h2 = 4'b1001;
	
	// Set up random number generator
	LFSR_generator g1(clk100hz, 4'b1010, rand);
	
	// Set up debounced buttons
	Debouncer(clock, ~buttons[0], runButton);
	Debouncer(clock, ~buttons[1], resetButton);
	
	// Set up clocks and timers
	Clock100hz clk100(clock, clk100hz);
	Clock1hz clk1(clock, clk1hz);
	
	
	always@(posedge clk1hz) begin
		if (state == 1) begin
			timer = timer + 1;
		end else begin
			timer = 0;
		end
	end
	
	// State machine
	wire timesMatch = (timer == readyTime);
	always@(posedge runButton or posedge resetButton or posedge timesMatch) begin
		if (resetButton == 1) begin
			state = 0;
		end else if (runButton == 1) begin
			case (state)
				0: begin
						state = 1;
						readyTime = rand;
					end
				2: begin
						state = 3;
					end
			endcase
		end else if (timesMatch) begin
			case (state)
				1: begin
						state = 2;
					end
			endcase
		end
	end
	
	always@(posedge (state == 3)) begin
		if ({h2, h1, h0} > {c2, c1, c0}) begin
			h0 = c0;
			h1 = c1;
			h2 = c2;
		end
	end
	
	assign highScore = switches[0];
	
	// set up counters and decoders
	wire clr = (state < 2);
	BCD_Counter BCD0(clk100hz & (state != 3), clr, c0, r0);
	BCD_Counter BCD1(r0, clr, c1, r1);
	BCD_Counter BCD2(r1, clr, c2, r2);
	
	// Decode ALL THE THINGS
	BCD_Decoder DG0(c0, d0);
	BCD_Decoder DG1(c1, d1);
	BCD_Decoder DG2(c2, d2);
	
	BCD_Decoder HD0(h0, hd0);
	BCD_Decoder HD1(h1, hd1);
	BCD_Decoder HD2(h2, hd2);
	
	// base output on state
	Multiplexer(state, 7'b1111111, 7'b1000000, d0, d0, SS5);
	Multiplexer(state, 7'b1111111, 7'b1000000, d1, d1, SS4);
	Multiplexer(state, 7'b1111111, 7'b1000000, d2, d2, SS3);
	Multiplexer({1'b0, highScore}, 7'b1111111, hd0, 7'b1111111, 7'b1111111, SS2);
	Multiplexer({1'b0, highScore}, 7'b1111111, hd1, 7'b1111111, 7'b1111111, SS1);
	Multiplexer({1'b0, highScore}, 7'b1111111, hd2, 7'b1111111, 7'b1111111, SS0);
	
	// turn on all lights to indicate timer has begun
	assign LEDs[9:0] = {10{state == 2}};
endmodule 