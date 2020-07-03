`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 06:45:16 PM
// Design Name: 
// Module Name: four_digit_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FourDigitOut(
    input [3:0] dig0,
    input [3:0] dig1,
    input [3:0] dig2,
    input [3:0] dig3,
    input [1:0] decimal,
    input clk,
    output reg [6:0] sev_seg = 0,
    output reg [3:0] an = 0,
    output reg dp = 0
    );
    
    wire [6:0] a,b,c,d;
    
    hexto7segment h0(.x(dig0), .r(a));
    hexto7segment h1(.x(dig1), .r(b));
    hexto7segment h2(.x(dig2), .r(c));
    hexto7segment h3(.x(dig3), .r(d));
    
    always@(posedge clk)
        case(an)
        4'b1110: begin 
                    an <= 4'b1101;
                    sev_seg <= b;
                    dp <= (decimal == 2'b01) ? 1'b0 : 1'b1;
                 end
        4'b1101: begin
                    an <= 4'b1011;
                    sev_seg <= c;
                    dp <= (decimal == 2'b10) ? 1'b0 : 1'b1;
                 end
        4'b1011: begin
                    an <= 4'b0111;
                    sev_seg <= d;
                    dp <= (decimal == 2'b11) ? 1'b0 : 1'b1;
                 end
        4'b0111: begin
                    an <= 4'b1110;
                    sev_seg <= a;
                    dp <= 1'b1;
                 end
        default: begin
                    an <= 4'b1110;
                    sev_seg <= a;
                    dp <= 1'b1;
                 end
        endcase
    
endmodule
