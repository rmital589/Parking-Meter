`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2019 11:24:55 PM
// Design Name: 
// Module Name: BCDCounter
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


module BCDCounter(
    input clk,
    input Enable,
    input Load,
    input Up,
    input Clr,
    input [3:0] D,
    output reg [3:0] Q  = 4'b0000,
    output C0
    );
    
    reg [26:0] divider = 0;
    wire div0 = (divider == 0) ? 1'b1 : 1'b0;
    
    always @ (negedge clk) begin
        if(divider < 99999999)
            divider = divider + 1;
        else
            divider = 0;
    end
    
    always @ (posedge clk or posedge Clr) 
    begin    
        if (Clr == 1'b1)
            Q <= 0;
        else begin
            if(Load)
                Q <= D;
            else if(!Load && Enable && Up && div0)
                Q <= (Q == 4'b1001) ? 4'b0000 : (Q + 1);
            else if(!Load && Enable && !Up && div0)
                Q <= (Q == 4'b0000) ? 4'b1001 : (Q - 1); 
            else
                Q <= Q;            
        end
    end
    
    assign C0 = ((Enable && Up && Q == 4'b1001) || (Enable && !Up && Q == 4'b0000)) ? 1'b1 : 1'b0;
    
endmodule
