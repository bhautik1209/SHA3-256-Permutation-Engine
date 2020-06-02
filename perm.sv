
`include "utop.sv"
`include "perm_algo.sv"
`include "pipe.sv"
`include "ptou.sv"
module perm(
input clk, 
input reset, 

input [2:0] dix,
input [199:0] din,
input pushin, 

output [2:0] doutix, 
output [199:0]dout,
output pushout
);
//String to  array parameters
wire pushout_s;
wire [23:0]doutix_s;
wire [4:0][4:0][63:0]A;
		
//algorithm output wires to link the perm.sv module    
wire [4:0][4:0][63:0]A5_0;
wire [4:0][4:0][63:0]A5_1;
wire [4:0][4:0][63:0]A5_2;
wire [4:0][4:0][63:0]A5_3;
wire [4:0][4:0][63:0]A5_4;
wire [4:0][4:0][63:0]A5_5;
wire [4:0][4:0][63:0]A5_6;
wire [4:0][4:0][63:0]A5_7;
wire [4:0][4:0][63:0]A5_8;
wire [4:0][4:0][63:0]A5_9;
wire [4:0][4:0][63:0]A5_10;
wire [4:0][4:0][63:0]A5_11;
wire [4:0][4:0][63:0]A5_12;
wire [4:0][4:0][63:0]A5_13;
wire [4:0][4:0][63:0]A5_14;
wire [4:0][4:0][63:0]A5_15;
wire [4:0][4:0][63:0]A5_16;
wire [4:0][4:0][63:0]A5_17;
wire [4:0][4:0][63:0]A5_18;
wire [4:0][4:0][63:0]A5_19;
wire [4:0][4:0][63:0]A5_20;
wire [4:0][4:0][63:0]A5_21;
wire [4:0][4:0][63:0]A5_22;
wire [4:0][4:0][63:0]A5_23;

//pipeline parameters to propagte data and push signals

wire [23:0]dix0,dix1,dix2,dix3,dix4,dix5,dix6,dix7;
wire  push_0,push_1,push_2,push_3,push_4,push_5,push_6,push_7;
wire [4:0][4:0][63:0]din0,din1,din2,din3,din4,din5,din6,din7;

//converting string to array (Unpacked array to packed array)
utop  u1(.clk(clk), .reset(reset), .pushin(pushin), .dix(dix), .din(din), .pushout(pushout_s), .doutix(doutix_s), .A(A));

//permutation round p0,.....p23 - 24 rounds
perm_algo  P0(.A(A),    .RC(64'h0000000000000001) , .A5(A5_0));
perm_algo  P1(.A(A5_0), .RC(64'h0000000000008082) , .A5(A5_1));
perm_algo  P2(.A(A5_1), .RC(64'h800000000000808A) , .A5(A5_2));

//propagating the signals (push and datasignals)
pipe p0 (.clk(clk), .reset(reset), .pushin(pushout_s), .dix(doutix_s), .din(A5_2), .pushout(push_0), .doutix(dix0), .dout_p(din0));


perm_algo P3 (.A(din0), .RC(64'h8000000080008000), .A5(A5_3));
perm_algo P4 (.A(A5_3), .RC(64'h000000000000808B), .A5(A5_4));
perm_algo P5 (.A(A5_4), .RC(64'h0000000080000001), .A5(A5_5));

pipe p1 (.clk(clk), .reset(reset), .pushin(push_0), .dix(dix0), .din(A5_5), .pushout(push_1), .doutix(dix1), .dout_p(din1));

perm_algo P6 (.A(din1), .RC(64'h8000000080008081), .A5(A5_6));
perm_algo P7 (.A(A5_6), .RC(64'h8000000000008009), .A5(A5_7));
perm_algo P8 (.A(A5_7), .RC(64'h000000000000008A), .A5(A5_8));

pipe p2 (.clk(clk), .reset(reset), .pushin(push_1), .dix(dix1), .din(A5_8), .pushout(push_2), .doutix(dix2), .dout_p(din2));

perm_algo P9 (.A(din2), .RC(64'h0000000000000088), .A5(A5_9));
perm_algo P10 (.A(A5_9), .RC(64'h0000000080008009), .A5(A5_10));
perm_algo P11 (.A(A5_10), .RC(64'h000000008000000A), .A5(A5_11));

pipe p3(.clk(clk), .reset(reset), .pushin(push_2), .dix(dix2), .din(A5_11), .pushout(push_3), .doutix(dix3), .dout_p(din3));



perm_algo P12 (.A(din3), .RC( 64'h000000008000808B), .A5(A5_12));
perm_algo P13 (.A(A5_12), .RC(64'h800000000000008B), .A5(A5_13));
perm_algo P14 (.A(A5_13), .RC( 64'h8000000000008089), .A5(A5_14));

pipe p4(.clk(clk), .reset(reset), .pushin(push_3), .dix(dix3), .din(A5_14), .pushout(push_4), .doutix(dix4), .dout_p(din4));


perm_algo P15 (.A(din4), .RC(64'h8000000000008003), .A5(A5_15));
perm_algo P16 (.A(A5_15), .RC(64'h8000000000008002), .A5(A5_16));
perm_algo P17 (.A(A5_16), .RC(64'h8000000000000080), .A5(A5_17));

pipe p5(.clk(clk), .reset(reset), .pushin(push_4), .dix(dix4), .din(A5_17), .pushout(push_5), .doutix(dix5), .dout_p(din5));


perm_algo P18 (.A(din5), .RC(64'h000000000000800A), .A5(A5_18));
perm_algo P19 (.A(A5_18), .RC(64'h800000008000000A), .A5(A5_19));
perm_algo P20 (.A(A5_19), .RC(64'h8000000080008081), .A5(A5_20));

pipe p6(.clk(clk), .reset(reset), .pushin(push_5), .dix(dix5), .din(A5_20), .pushout(push_6), .doutix(dix6), .dout_p(din6));

perm_algo P21 (.A(din6), .RC(64'h8000000000008080), .A5(A5_21));
perm_algo P22 (.A(A5_21), .RC(64'h0000000080000001), .A5(A5_22));
perm_algo P23 (.A(A5_22), .RC(64'h8000000080008008), .A5(A5_23));

pipe p7(.clk(clk), .reset(reset), .pushin(push_6), .dix(dix6), .din(A5_23), .pushout(push_7), .doutix(dix7), .dout_p(din7));


//coverting packed to unpacked and this module will give the final dout
ptou p8 (.clk(clk), .reset(reset), .pushin(push_7),.dix(dix7),.din(din7), .pushout(pushout), .doutix(doutix), .dout(dout));


endmodule
