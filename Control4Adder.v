module Control4Adder(
input loadBCD,
input reset1,
input reset2,
input buttonU,
input buttonL,
input buttonR,
input buttonD,
input [15:0]Y,
output [15:0]adder_out,
output [3:0]Cout
);

wire [15:0]X;
wire [15:0]Z;
wire [15:0]Y2;
wire [3:0] button;
wire [1:0] reset;
reg [15:0] X1;
reg [15:0] Z1;
reg [15:0] Y1;

assign button = {buttonU,buttonL,buttonR,buttonD};
assign reset = {reset1,reset2};
initial 
begin
X1<=0;
Z1<=0; 
Y1<=0;
end
always @(*)
begin
    if(loadBCD)
    Y1<=Y;
    else
    Y1<=0; 
end
assign Y2 = Y1;
always @(*)
begin 
		case(button)
		4'b1000: X1<=16'b0000000000010000;
		4'b0100: X1<=16'b0000000110000000;
		4'b0010: X1<=16'b0000001000000000;
		4'b0001: X1<=16'b0000010101010000;
		default: X1<=0;
		endcase
	
end

assign X = X1;
assign adder_out = (~reset1 && ~reset2) ?  Z : Z1;
BCD_Adder_16 B5 (X, Y2, Z, Cout);

always @(*)
begin 
	case(reset)
        2'b10: Z1<=16'b0000000000010000;
	    2'b01: Z1<=16'b0000001000000101;
	default:Z1<=0;
	endcase
		
end 

endmodule
