`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2018 05:34:20 PM
// Design Name: 
// Module Name: buttonPressCounter
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


module buttonPressCounter(  input   logic           countButton,     // when initially pressed, should increment LED counter
                            input   logic           resetButton,     // when pressed, should reset the counter 
                            input   logic           clk,             // clock
                            output  logic   [15:0]  led,
                            output  logic   [6:0]   SSD_LED_out,
                            output  logic   [3:0]   Anode_Activate    );            // leds showing the current number

    logic   [15:0]  number;
    logic   [1:0]   lastTwoButtonValues;  
    logic           buttonLogicValue;
    
    conditioner conditionerInstance( .clk(clk),
                                     .buttonPress(countButton),
                                     .conditionedSignal(buttonLogicValue) );
     always_ff @ ( posedge clk ) begin
                                        
          if( resetButton ) begin
             led <= 16'b0;
             lastTwoButtonValues <= 2'b00;
                end
          else
            lastTwoButtonValues = {lastTwoButtonValues[0], buttonLogicValue };
               if( lastTwoButtonValues == 2'b01 ) begin // if there is a rising edge in the button press
               led <= led + 1;
             end
                                            
         end
            
    sevenseg   sevensegInstance(
                     .clk(clk),
                     .displayed_number(number),
                     .SSD_LED_out(SSD_LED_out), 
                     .Anode_Activate(Anode_Activate)   // the 4 bit enable signal
                     );

    assign led = number;

endmodule
