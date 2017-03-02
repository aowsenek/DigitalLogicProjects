module Arithmetic(input [1:0] mode, input [7:0] i, output [7:0] o, output carry);
	wire [7:0] oa, os, om, od;
	wire ca, cs, cm;
	full_add a(i[3:0], i[7:4], oa, ca);
	subtract s(i[3:0], i[7:4], os, cs);
	mult_by_2 m(i[7:0], om, cm);
	div_by_2 d(i[7:0], od);
	
	Multiplexer no(mode, oa, os, om, od, o);
	Multiplexer nc(mode, ca, cs, cm, 0, carry);
endmodule

module mult_by_2(input [7:0] i, output [7:0] o, output carry);
	assign o[7:1] = i[6:0];
	assign carry = i[7];
endmodule

module div_by_2(input [7:0] i, output [7:0] o);
	assign o[6:0] = i[7:1];
	assign o[7] = 0;
endmodule

module subtract(x, y, s, cout);
	parameter n = 8;
	input [n-1:0]x;
	input [n-1:0]y;
	output [n-1:0]s;
	output cout;
	assign s = 0;
endmodule


module add(input x, input y, input cin, output reg s, output reg cout);
  always @ (x, y, cin)
  begin
    cout = (x&y)|(y&cin)|(x&cin);
    s = x ^ y ^ cin;
  end
endmodule

module full_add(x, y, s, cout);
  parameter n = 8;
  input [n-1:0]x;
  input [n-1:0]y;
  output [n-1:0]s;
  output cout;
  wire [n:0]c;

  generate
  genvar i;
    for(i = 0; i < n; i = i + 1)
    begin: genStages
      add stage(x[i], y[i], c[i], s[i], c[i+1]);
    end
  endgenerate

  assign c[0] = 0;
  assign cout = c[n];
endmodule