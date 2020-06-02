module pipe(
input clk,
input reset,

input pushin,
input [23:0] dix,
input [4:0][4:0][63:0]din,

output reg pushout,
output reg [23:0] doutix,
output reg [4:0][4:0][63:0]dout_p
);

always @(posedge clk or posedge reset) begin

    if(reset) begin
        pushout <= 0;
        doutix  <= 0;
        dout_p <= 0;
    end
    else begin
        pushout <= #1 pushin;
        doutix  <= #1 dix;
        dout_p <=  din;
    end

end

endmodule
