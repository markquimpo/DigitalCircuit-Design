`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2018 01:18:15 PM
// Design Name: 
// Module Name: tBirdTaillightTop
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


module tBirdTaillightTop(   input logic clk,
                            input logic [15:0] sw,
                            input logic btnC,
                            input logic btnU,
                            output logic [15:0] led
                         );

    logic clk_1Hz;

    logic [2:0] leftLEDs;
    logic [2:0] rightLEDs;

    slowClock slowClockInstance(.clk(clk), .reset(btnU), .clk_1Hz(clk_1Hz));

    taillight leftTaillight(.clk(clk_1Hz), .reset(btnU), .brake(btnC), .turnSignal(sw[15]), .taillights(leftLEDs));
    taillight rightTaillight(.clk(clk_1Hz), .reset(btnU), .brake(btnC), .turnSignal(sw[0]), .taillights(rightLEDs));
    


    assign led[15:13] = {leftLEDs[0], leftLEDs[1], leftLEDs[2]};
    assign led[12:3] = 10'b00000_00000;
    assign led[2:0] = {rightLEDs[2], rightLEDs[1], rightLEDs[0]};
    
endmodule
