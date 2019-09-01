`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2018 01:39:25 PM
// Design Name: 
// Module Name: workSheet2ALU
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


module workSheet2ALU(   input logic signed  [7:0] a,b,
                        input logic         btnU, btnL, btnC, btnR, btnD,
                        output logic        [7:0] led );

    // write the logic for the ALU here
    always_comb
    //  up button should correspond to a + b
        if (btnU)
            led = a + b;
    //  left button should correspond to a XOR b
        else if (btnL)
            led = a ^ b;
    //  center button should correspond to 8'b0000_0001 if a < b, 8'b0000_0000 otherwise
        else if (btnC)
            if (a<b)
                led = 8'b0000_0001;
            else
                led = 8'b0000_0000;
    //  right button should correspond to arithmetic right shift by 2
        else if (btnR)
             led = b >>> 2;
    //  down button should correspond to a - b
        else if (btnD)
             led = a - b;
        else 
             led = 8'b0000_0000;
    // the output of the ALU should be assigned to led, which maps to the rightmost 8 leds on your BASYS3
    // (this mapping has already been done in Basys3_Master.xdc)
endmodule
