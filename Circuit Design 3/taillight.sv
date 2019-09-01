`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2018 01:38:46 PM
// Design Name: 
// Module Name: taillight
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


module taillight(   input logic clk,
                    input logic reset,
                    input logic brake,
                    input logic turnSignal,
                    output logic [2:0] taillights
                );
    
    logic [2:0] blinkingLights;
    blinkers blinkersInstance( .clk(clk), .reset(reset), .turnSignal(turnSignal), .blinkingLights(blinkingLights));

    always_comb
    begin
            if (turnSignal == 1)
                begin
                    taillights = blinkingLights;
                end
            else if (brake == 1)
                begin
                    taillights = 3'b111;
                end
            else
                taillights = 3'b000;
    end
endmodule
