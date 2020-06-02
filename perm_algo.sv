module perm_algo(input clk, input reset,
input [4:0][4:0][63:0]A,
input [63:0]RC,
output reg [4:0][4:0][63:0]A5
);
reg [4:0][4:0][63:0]A1,A2,A3,A4;
reg [4:0][63:0]C;
reg [4:0][63:0]D;
reg [8:0]tab[0:4][0:4];

function int rem (input int x, input int y);
	return ((x%y < 0) ? ((x%y)+y) : (x%y));
endfunction


function [5:0]rem_ro;

    input [8:0]x;
    input [8:0]y;
  
    if(x<y)begin
		if(y-x<64)
		rem_ro= 64-(y-x);
        else
		rem_ro= 64-(y-x-256);
	end
	else
		rem_ro= x-y;
		
endfunction

always @(*) begin

//theta algorithm
 
    for(int x=0;x<5;x=x+1)begin
        for(int z=0;z<64;z=z+1)begin
            C[x][z] = A[x][0][z]^A[x][1][z]^A[x][2][z]^A[x][3][z]^A[x][4][z];
        end
    end
    for(int x=0;x<5;x=x+1)begin
        for(int z=0;z<64;z=z+1)begin
    		D[x][z] = C[rem((x-1),5)][z] ^ C[rem((x+1),5)][rem((z-1),64)];
        end
    end
    
    for(int x=0;x<5;x=x+1)begin
        for(int y=0;y<5;y=y+1)begin
            for(int z=0;z<64;z=z+1)begin
                A1[x][y][z] = A[x][y][z]^D[x][z];
            end
        end
    end




	//rho algorithm
 //as mentioned in the table for ro algortihm
       

tab[0][0] = 0  ;  
tab[0][1] = 36 ; 
tab[0][2] = 3  ;
tab[0][3] = 105;
tab[0][4] = 210;
tab[1][0] = 1  ;
tab[1][1] = 300;
tab[1][2] = 10 ;
tab[1][3] = 45 ;
tab[1][4] = 66 ;
tab[2][0] = 190;
tab[2][1] = 6  ;
tab[2][2] = 171;
tab[2][3] = 15 ;
tab[2][4] = 253;
tab[3][0] = 28 ;
tab[3][1] = 55 ;
tab[3][2] = 153;  
tab[3][3] = 21 ;
tab[3][4] = 120;
tab[4][0] = 91 ;	           	
tab[4][1] = 276; 
tab[4][2] = 231;
tab[4][3] = 136;                           
tab[4][4] = 78 ;           

    for(int x=0;x<5;x=x+1)begin
        for(int y=0;y<5;y=y+1)begin
            for(int z=0;z<64;z=z+1)begin
                A2[x][y][z] = A1[x][y][rem_ro(z,tab[x][y])];
            end
        end
    end

//pi algorithm
for(int x=0;x<5;x=x+1)begin
        for(int y=0;y<5;y=y+1)begin
            for(int z=0;z<64;z=z+1)begin
               A3[x][y][z] = A2[rem((x+3*y),5)][x][z];
            end
        end
    end




//chi algorithm

    for(int x=0;x<5;x=x+1)begin
        for(int y=0;y<5;y=y+1)begin
            for(int z=0;z<64;z=z+1)begin
               	A4[x][y][z] = A3[x][y][z] ^ ((A3[rem(x+1,5)][y][z]^1) & (A3[rem((x+2),5)][y][z]));
            end
        end
    end

//iota algorithm
for(int x=0;x<5;x=x+1)begin
        for(int y=0;y<5;y=y+1)begin
            for(int z=0;z<64;z=z+1)begin
                if(x==0 && y==0)
                  A5[x][y][z] = A4[x][y][z] ^ RC[z]; //as mentioned in algorithm 6 step 4
                else
                  A5[x][y][z] = A4[x][y][z]; //as mentioned in algorithm 6 step 1
            	end
        	end
    		end

end
endmodule

