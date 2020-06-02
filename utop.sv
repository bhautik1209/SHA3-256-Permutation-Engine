module utop(input clk, input reset, input [2:0] dix,input [199:0] din,
input pushin, output reg [23:0] doutix,
output reg pushout,output reg [4:0][4:0][63:0]A);


reg [199:0] dout;
reg push;
reg [23:0]dix1;
reg [1599:0]S;



//string to state  array conversion

always @ (posedge clk or posedge reset)begin
if(reset)begin

push <= 0;
dix1 <=0;
S<=0;

end


else begin
if(pushin)begin
S <= #1 {din,S[1599:200]};
dix1 <= #1 {dix,dix1[23:3]};

end
else begin
S <= S;
dix1<=dix1;
end


if(dix == 3'd7)begin
push <= #1 pushin;
end
else begin
push <= 0;
end
end
end
always @(*) begin

	pushout = push;
	doutix = dix1;
	
		for(int x=0;x<5;x=x+1)begin
			for(int y=0;y<5; y=y+1)begin
				for(int z=0;z<64;z=z+1)begin
			
				A[x][y][z]=S[64*(5*y+x)+z];
				end
			end
		end
end


endmodule

























