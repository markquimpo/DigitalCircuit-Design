//complete this module
  module sevenSegmentRamAssignment( input   logic           storeButton,     // when initially pressed, should increment LED counter
                                    input   logic           upButton,
                                    input   logic           downButton,          
                                    input   logic           clk,             // clock
                                    input   logic   [15:0]  sw,             // clock
                                    output  logic   [3:0]   led,
                                    output  logic   [6:0]   SSD_LED_out,
                                    output  logic   [3:0]   Anode_Activate    );            // leds showing the current number


    logic       buttonLogicValueStore;
    logic       buttonLogicValueUp;
    logic       buttonLogicValueDown;
    logic       [1:0]  lastTwoStoreButtonValues; 
    logic       [1:0]  lastTwoTopButtonValues;
    logic       [1:0]  lastTwoDownButtonValues;
    logic       [15:0] displaynumber;
    logic       [15:0] counter;
    
   
    conditioner conditionerInstancestore( .clk(clk),
                                          .buttonPress(storeButton),
                                          .conditionedSignal(buttonLogicValueStore) );    
     
     
     conditioner conditionerInstanceup(   .clk(clk),
                                          .buttonPress(upButton),
                                          .conditionedSignal(buttonLogicValueUp) );  
                                        
     conditioner conditionerInstancedown( .clk(clk),
                                          .buttonPress(downButton),
                                          .conditionedSignal(buttonLogicValueDown) ); 
         
                                          
          always_ff @ ( posedge clk ) begin
            
         // lastTwoStoreButtonValues = {lastTwoStoreButtonValues[0], buttonLogicValueStore };
          lastTwoTopButtonValues =  {lastTwoTopButtonValues[0], buttonLogicValueUp };
          lastTwoDownButtonValues = {lastTwoDownButtonValues[0], buttonLogicValueDown };
                                        
         if (lastTwoTopButtonValues == 2'b01 )
                 counter <= counter + 1;
         else if (lastTwoDownButtonValues == 2'b01 )
                  counter <= counter - 1;
         
         end
                                          
    sevenseg   sevensegInstance(  .clk(clk),
                                  .displayed_number(displaynumber),
                                  .LED_out(SSD_LED_out), 
                                  .Anode_Activate(Anode_Activate)   );  
                                                                           
   
    assign led = counter;
                                          
                                               
                                               
     ram ramInstance( .clk(clk),
                      .we(buttonLogicValueStore),
                      .adr(counter),
                      .din(sw[15:0]),
                      .dout(displaynumber)
                       );
                                              
                                             
    
    // the up and down buttons are used to select a 4-bit address from ram
    // the current address is displayed using the 4 rightmost leds
    // the value currently stored at that address in ram is displayed on the 7 segment display
    
    // the value to be written to ram is given by the switches
    
    // when the center button is pressed (corresponding to the debounced storeButton), the value corresponding to switches should be written into ram 


endmodule
