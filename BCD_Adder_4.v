module BCD_Adder_4 (

input [3:0] X,
input [3:0] Y,
input [3:0] Cin,
output [3:0]Z,
output[3:0] Cout);

wire [4:0] S;


assign S = X[3:0] + Y[3:0] + Cin[3:0];
assign Z = (S > 9) ? S[3:0] + 6 : S[3:0];
assign Cout = (S > 9) ? 4'b0001 : 4'b0000;

endmodule
