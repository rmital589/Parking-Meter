`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2019 12:26:08 AM
// Design Name: 
// Module Name: 2BitBCD
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


module FourDigBCD(
    input Clr,
    input clk,
    input Enable,
    input Load,
    input Up,
    input  [15:0] D,
    output [15:0] Q,
    output CO
    );
    
    wire C01, C02, C03, C04;
    
    BCDCounter b1(clk, Enable, Load, Up, Clr, D[3:0], Q[3:0], C01);
    BCDCounter b2(clk, C01, Load, Up, Clr, D[7:4], Q[7:4], C02);
    BCDCounter b3(clk, C02, Load, Up, Clr, D[11:8], Q[11:8], C03);
    BCDCounter b4(clk, C03, Load, Up, Clr, D[15:12], Q[15:12], C04);
    
    assign CO = (Enable && Up && Q == 16'h9999) || (Enable && !Up && Q == 16'h0000) ? 1'b1 : 1'b0;
    
endmodule
