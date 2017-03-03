module Magic(input clk, output reg [10:0]magic);
	reg left;
	
	// start with three bits on
	initial begin
		magic = 3'b111;
	end
	
	// change direction when lights on edge turn on
	always @ (magic[0] or magic[9]) begin
		if (magic[0]==1) begin
			left = 0;
		end
		else if (magic[9]==1) begin
			left = 1;
		end
	end
	
	// shift bits, using slot 10 to store overflow temporarily
	always @ (posedge clk) begin
		if (left==1) begin
			magic = magic >> 1;
			magic[10] = magic[0];
		end else begin
			magic = magic << 1;
			magic[0] = magic[10];
		end
	end
endmodule
