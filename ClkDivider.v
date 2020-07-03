`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2019 12:57:26 AM
// Design Name: 
// Module Name: ClkDivider
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


module ClkDivider #(parameter num_bits = 31, parameter div_factor = 100000000) (
    input inclk,
    output reg outclk
    );
    
    reg reset = 0;
    reg [num_bits:0] divider = 0;
    
    always@(divider) begin
        reset <= 1'b0;
        if(divider == (div_factor >> 1))
            reset <= 1'b1;
    end
    
    always@(posedge inclk) begin
        if(reset) begin
            outclk <= outclk ^ reset;
            divider <= 0;
        end else begin
            divider <= (divider + 1);
        end
    end
    
    
endmodule
