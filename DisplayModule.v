`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2019 10:39:29 PM
// Design Name: 
// Module Name: DisplayModule
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


module DisplayModule(
    input clk,
    input buttonU,
    input buttonL,
    input buttonR,
    input buttonD,
    input sw0,
    input sw1,
    output [3:0] an,
    output [6:0] sev_seg,
    output dp
    );
    
    reg [1:0] Sw0Reg = 0, Sw1Reg = 0;
    reg BCDEnable = 1'b1;
    reg flashState = 1'b0;
    reg [6:0] sevSeg2Hz = 0 , sevSeg1Hz = 0;
    
    wire clk30Hz, clk2Hz, clk0_5Hz, clk240Hz, clk_25MHz;
    wire stableButtonU, stableButtonL, stableButtonR, stableButtonD;
    wire loadBCD, CO;
    wire [6:0] sevSegOut;
    wire [15:0] newBCD, parkingTime;
    wire [3:0] Cout;
    
    ClkDivider #(22, 3333333) c0 (clk, clk30Hz);
    ClkDivider #(27, 50000000) c1 (clk, clk2Hz);
    ClkDivider #(16, 41666) c2 (clk, clk240Hz);
    //ClkDivider #(28, 200000000) c3 (clk, clk0_5Hz);
    //ClkDivider #(3, 4) c4(clk, clk_25MHz);
    
    SynchSinglePulse ssp0(buttonU, clk30Hz, clk, stableButtonU);
    SynchSinglePulse ssp1(buttonL, clk30Hz, clk, stableButtonL);
    SynchSinglePulse ssp2(buttonR, clk30Hz, clk, stableButtonR);
    SynchSinglePulse ssp3(buttonD, clk30Hz, clk, stableButtonD);
    
    always@(negedge clk) begin
        Sw0Reg[0] <= sw0;
        Sw0Reg[1] <= Sw0Reg[0];     
        Sw1Reg[0] <= sw1;
        Sw1Reg[1] <= Sw1Reg[0];
    end
    
    assign loadBCD = stableButtonU | stableButtonL | stableButtonR |stableButtonD | Sw1Reg[1] | Sw0Reg[1];
    
    FourDigBCD M1 (1'b0, clk, BCDEnable, loadBCD, 1'b0, newBCD, parkingTime, CO);
    Control4Adder M2 (loadBCD, sw0, sw1, stableButtonU, stableButtonL, stableButtonR, stableButtonD, parkingTime, newBCD, Cout);
    FourDigitOut M3 (parkingTime[3:0], parkingTime[7:4], parkingTime[11:8], parkingTime[15:12], 2'b00, clk240Hz, sevSegOut, an, dp);
    
    always@(parkingTime) begin
        if(parkingTime > 0 && loadBCD == 0)
            BCDEnable <= 1'b1;
        else
            BCDEnable <= 1'b0;
    end
    
    always@(parkingTime, loadBCD) begin
        if(parkingTime <= 16'h0200 && loadBCD == 0 && parkingTime > 0)
            sevSeg2Hz <= (parkingTime[0]) ? 7'hFF : 0;
        else
            sevSeg2Hz <= 0;
    end
    
    always@(posedge clk2Hz) begin
        if(parkingTime == 0)
            sevSeg1Hz <= (sevSeg1Hz == 7'hFF) ? 0 : 7'hFF;
        else
            sevSeg1Hz <= 0;
    end
    
    assign sev_seg = sevSeg2Hz | sevSeg1Hz | sevSegOut;//(parkingTime <= 16'h0200) ? ((parkingTime > 0) ? sevSeg2Hz : sevSeg1Hz) : sevSegOut;

    
    
    
    
endmodule
