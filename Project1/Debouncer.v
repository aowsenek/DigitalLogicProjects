// https://www.eecs.umich.edu/courses/eecs270/270lab/270_docs/debounce.html
module Debouncer(input clk, input PB, output reg PB_state);

// Synchronize the switch input to the clock
reg PB_sync_0;
always @(posedge clk) PB_sync_0 <= PB;
reg PB_sync_1;
always @(posedge clk) PB_sync_1 <= PB_sync_0;

// Debounce the switch
reg [15:0] PB_cnt;
always @(posedge clk)
if(PB_state == PB_sync_1)
    PB_cnt <= 0;
else
begin
    PB_cnt <= PB_cnt + 1'b1; 
    if(PB_cnt == 16'h3fff) PB_state <= ~PB_state; 
end
endmodule

