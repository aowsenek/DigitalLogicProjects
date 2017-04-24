// used to test
module Clock1hz(input clk10Mhz, output reg o);
	parameter p = 20000000;
	reg [24:0] count_reg = 0;
	
	always @(posedge clk10Mhz) begin
	  if (count_reg < p) begin
			count_reg <= count_reg + 1;
	  end else begin
			count_reg <= 0;
			o <= ~o;
	  end
	end
endmodule

// used for debouncing
module Clock10hz(input clk10Mhz, output reg o);
	parameter p = 2000000;
	reg [22:0] count_reg = 0;
	
	always @(posedge clk10Mhz) begin
	  if (count_reg < p) begin
			count_reg <= count_reg + 1;
	  end else begin
			count_reg <= 0;
			o <= ~o;
	  end
	end
endmodule

// used for counting
module Clock100hz(input clk10Mhz, output reg o);
	parameter p = 200000;
	reg [22:0] count_reg = 0;
	
	always @(posedge clk10Mhz) begin
	  if (count_reg < p) begin
			count_reg <= count_reg + 1;
	  end else begin
			count_reg <= 0;
			o <= ~o;
	  end
	end
endmodule
