`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:13:38 PM
// Design Name: 
// Module Name: vga_top
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

module vga_top(
    input wire clk,           
    input wire rst,            
    input wire btn_dot,        
    input wire btn_dash,       
    input wire btn_enter, 
    input wire btn_space,     
    output wire h_sync,        
    output wire v_sync,        
    output wire led_on,        
    output reg [11:0] rgb,
    output [7:0] letter
);

    wire ready;
    wire newClk;        
    wire stableButton;
    
     clk_divider clock(
        .clk(clk),
        .reset(rst),
        .newClk(newClk)
        );
   
    top_2 morse_code_inst(
        .clk(newClk),
        .rst(rst),
        .btn_dot(btn_dot),
        .btn_dash(btn_dash),
        .btn_enter(btn_enter),
        .btn_space(btn_space),
        .letter(letter),   // Output the translated letter (ASCII)
        .ready(ready),
        .check_dot(),
        .check_dash(),
        .btn_enter_posedge(stableButton)
    );
    
    vga_controller vga_inst(
        .clk(newClk),
        .rst(rst),
        .btn_enter(stableButton),
        .letter(letter),    // Input the translated letter (ASCII)
        .h_sync(h_sync),    
        .v_sync(v_sync),    
        .led_on(led_on)    
    );
    
    always @(posedge newClk) begin
        if(led_on) begin 
            rgb=12'hfff;
        end else begin
            rgb=0;
        end
     end
     
endmodule
