`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2019 10:29:44 PM
// Design Name: 
// Module Name: SynchSinglePulse
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


module SynchSinglePulse(
    input buttonIn,
    input button_clk,
    input clk,
    output stableButton
    );
    
    reg synch0 = 1'b0, synch1 = 1'b0, synch2 = 1'b0;
    reg synch00 = 1'b0, synch01 = 1'b0, synch10 = 1'b0;
    wire debouncedButton;
    
    always@(posedge button_clk) begin
        //double synchronizer circuit
        synch0 <= buttonIn;
        synch1 <= synch0;
        synch2 <= synch1;
    end
    
    assign debouncedButton = !synch2 & synch1;
    
    always@(posedge clk) begin
        //double synchronizer circuit
        synch00 <= debouncedButton;
        synch01 <= synch00;
        synch10 <= synch01;
    end
    
    assign stableButton = !synch10 & synch01;
    
endmodule
