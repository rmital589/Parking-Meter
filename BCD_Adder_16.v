module BCD_Adder_16(
input [15:0]X,
input [15:0]Y,
output [15:0]out,
output [3:0]Cout);

wire [3:0] C1,C2,C3;
wire [15:0] Z;




BCD_Adder_4 B1 ( X[3:0],Y[3:0],4'b0000,Z[3:0],C1);
BCD_Adder_4 B2 ( X[7:4],Y[7:4],C1,Z[7:4],C2);
BCD_Adder_4 B3 ( X[11:8],Y[11:8],C2,Z[11:8],C3);
BCD_Adder_4 B4 ( X[15:12],Y[15:12],C3,Z[15:12],Cout);

assign out = (Cout==0) ?  Z : 16'b1001100110011001;


endmodule
