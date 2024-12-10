`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 05:40:36 PM
// Design Name: 
// Module Name: debouncer_tb
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

//Testbench for our debouncer module  
module debouncer_tb(
 
    );    
 
    reg clk;
    reg rst;
    reg btn;

    
    wire btn_stable;
    wire btn_stable_posedge;
    
    debounce uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .btn_stable(btn_stable),
        .btn_stable_posedge(btn_stable_posedge)
        );
    
    always begin
        #5 clk = ~clk; 
    end

    initial begin
        clk = 0;
        rst = 0;
        btn = 0;

        rst = 1;
        #20;
        rst = 0;
        #10;  
    
        btn = 1;  
        #20;     
        btn = 0;  
        #20;
        btn = 1;  
        #20;
        btn = 0;  
        #20;
        btn = 1;  
        #20;
        btn = 0;  
        #20;
        #50;   
        
        btn = 1;  
        #20;     
        btn = 0;  
        #20;
        btn = 1;  
        #20;
        btn = 0;  
        #20;
        btn = 1;  
        #20;
        #20;
        #5000;    
        btn = 0;  
        #5000;    
        rst = 1;  
        #20;
        rst = 0;  
        #5000;   
        btn = 0;  
        #5000;    
    
        $finish;
    end

endmodule
    