module sevenseg(    input   logic           clk, // 100 Mhz clock source on Basys 3 FPGA
                    input   logic   [15:0]  displayed_number, //number to be displayed
                    output  logic   [3:0]   Anode_Activate, // anode signals of the 7-segment LED display
                    output  logic   [6:0]   SSD_LED_out// cathode patterns of the 7-segment LED display
                    );
      
    logic [3:0] LED_BCD;
    logic [20:0] refresh_counter; // the first 19-bit for creating 190Hz refresh rate
             // the other 2-bit for creating 4 LED-activating signals
    logic [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat

    always_ff @(posedge clk)
        refresh_counter <= refresh_counter + 1;
  
    assign LED_activating_counter = refresh_counter[20:19];
    // anode activating signals for 4 LEDs
    // decoder to generate anode signals 
    always_comb
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;
            // the fourth digit of the 16-bit number    
               end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always_comb
    begin
        case(LED_BCD)
        4'b0000: SSD_LED_out = 7'b0000001; // "0"     
        4'b0001: SSD_LED_out = 7'b1001111; // "1" 
        4'b0010: SSD_LED_out = 7'b0010010; // "2" 
        4'b0011: SSD_LED_out = 7'b0000110; // "3" 
        4'b0100: SSD_LED_out = 7'b1001100; // "4" 
        4'b0101: SSD_LED_out = 7'b0100100; // "5" 
        4'b0110: SSD_LED_out = 7'b0100000; // "6" 
        4'b0111: SSD_LED_out = 7'b0001111; // "7" 
        4'b1000: SSD_LED_out = 7'b0000000; // "8"     
        4'b1001: SSD_LED_out = 7'b0000100; // "9" 
        default: SSD_LED_out = 7'b0000001; // "0"
        endcase
    end
 endmodule
