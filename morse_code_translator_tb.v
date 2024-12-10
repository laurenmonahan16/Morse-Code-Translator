`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:56:46 PM
// Design Name: 
// Module Name: morse_code_translator_tb
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

//Testbench to test top_2 module 
module morse_code_translator_tb(

    );
    reg clk;
    reg rst;
    reg btn_dot;    
    reg btn_dash;   
    reg btn_enter;
    reg btn_space;
    reg  [7:0] letter;
    reg check_dot;
    reg check_dash;
    reg check_space; 
    reg btn_enter_posedge; 

    top_2 uut(
        .clk(clk),
        .rst(rst),
        .btn_dot(btn_dot),
        .btn_dash(btn_dash),
        .btn_enter(btn_enter),
        .btn_space(btn_space),
        .letter(letter),   
        .ready(ready),
        .check_dot(),
        .check_dash(),
        .check_space(),
        .btn_enter_posedge(stableButton)
    );

   
    always begin
        #2 clk = ~clk; 
    end

   
    initial begin
        clk = 0;
        rst = 0;
        btn_dot = 0;
        btn_dash = 0;
        btn_enter = 0;

        rst = 1;
        #10 rst = 0;
        
        //L
        #50 btn_dash = 1; 
        #10 btn_dash = 0; 
        #50 btn_dot = 1;  
        #10 btn_dot = 0;  
        #50 btn_dot = 1;  
        #10 btn_dot = 0;  
        #50 btn_enter = 1; 
        #50 btn_enter = 0;

        #10;
        
        //A
        #50 btn_dot = 1; 
        #10 btn_dot = 0;  
        #50 btn_dash = 1; 
        #10 btn_dash = 0; 
        #50 btn_enter = 1; 
        #50 btn_enter = 0; 

        #10;

        $finish;
    end
    
endmodule
