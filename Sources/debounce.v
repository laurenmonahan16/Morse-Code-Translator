`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:39:20 PM
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A debouncing circuit to stabilize button presses and detect positive edges
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Fixed debounce logic
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module debounce(
    input wire clk,           
    input wire rst,          
    input wire btn,           // Input button (e.g., btn_dot, btn_dash, btn_enter)
    output reg btn_stable,    // Debounced stable button output
    output reg btn_stable_posedge // Debounced positive edge detection
);
    reg [15:0] counter;       // Counter for debounce timing
    reg btn_sync1, btn_sync2; // Synchronize the button signal
    reg btn_stable_prev;      // Previous stable state of the button

    parameter DEBOUNCE_TIME = 50000; 

    // Synchronize the button signal to the clock domain
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_sync1 <= 0;
            btn_sync2 <= 0;
        end else begin
            btn_sync1 <= btn;
            btn_sync2 <= btn_sync1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            btn_stable <= 0;
            btn_stable_posedge <= 0;
            btn_stable_prev <= 0;
        end else begin
            if (btn_sync2 == btn_stable) begin
                // If button state matches stable state, reset the counter
                counter <= 0;
                btn_stable_posedge <= 0;
            end else begin
                // Increment the counter if button state is changing
                if (counter >= DEBOUNCE_TIME) begin
                    // If debounce time is met, update stable state
                    btn_stable <= btn_sync2;
                    counter <= 0;

                    // Detect positive edge of the stable button signal
                    if (!btn_stable_prev && btn_sync2) begin
                        btn_stable_posedge <= 1;
                    end else begin
                        btn_stable_posedge <= 0;
                    end
                end else begin
                    counter <= counter + 1;
                    btn_stable_posedge <= 0;
                end
            end

            // Update the previous stable button state
            btn_stable_prev <= btn_stable;
        end
    end

endmodule
