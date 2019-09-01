`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2018 01:43:41 PM
// Design Name: 
// Module Name: blinkers
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


module blinkers( input  logic       clk,
                 input  logic       reset,
                 input  logic       turnSignal,
                 output logic [2:0] blinkingLights );
    
    typedef enum logic [1:0] {S0, S1, S2, S3} statetype;
    statetype state, nextstate;
    
    always_ff @( posedge clk, posedge reset)
    begin
        if( reset )
            state <= S0;
        else
            state <= nextstate;
    end
    

    always_comb
    begin 
        case(state)
        S0:        if(turnSignal == 0) nextstate = S0;
                   else                nextstate = S1;
        S1:        if(turnSignal == 1) nextstate = S2;
                   else                nextstate = S0;
        S2:        if(turnSignal == 1) nextstate = S3;
                   else                nextstate = S0;
        S3:                            nextstate = S0;
        default:                       nextstate = S0;

        endcase;
    end

    assign blinkingLights[2] = (state == S1) || (state == S2) || (state == S3);
    assign blinkingLights[1] = (state == S2) || (state == S3);
    assign blinkingLights[0] = (state == S3);
   
endmodule

