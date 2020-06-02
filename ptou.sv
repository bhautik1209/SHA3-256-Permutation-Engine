module ptou(
input clk,
input reset,

input pushin,
input [23:0]dix,
input [4:0][4:0][63:0]din,

output reg pushout,
output reg [2:0]doutix,
output reg [199:0]dout
);


reg [1599:0] S1,S2;
reg [7:0] push;
reg [23:0]dix1;

always @(*) begin
    for(int x=0;x<5;x=x+1) begin
        for(int y=0;y<5;y=y+1) begin
            for(int z=0;z<64;z=z+1) begin
                S2[64*(5*y+x)+z] = din[x][y][z];
            end
        end
    end
end

always @(posedge clk or posedge reset) begin

if(reset) begin
push<=0;
dix1<=0;
S1<=0;
end
else begin

push <= #1 {push[6:0],pushin};


if(pushin) begin
dix1 <= #1 dix;
S1 <= #1 S2;
end
else begin

dix1<= #1{3'b0,dix1[23:3]};
S1 <= #1 {200'b0,S1[1599:200]};

end
end
end


always @ (*) begin
pushout = push[0] | push[1] | push[2] | push[3] | push [4] | push [5] | push [6] | push[7];
doutix = dix1[2:0];
dout = S1[199:0];





end


endmodule
