`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 02:42:09 PM
// Design Name: 
// Module Name: morse_code_translator
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


module top_2(
    input wire clk,            
    input wire rst,            
    input wire btn_dot,      
    input wire btn_dash,      
    input wire btn_enter,     
    input wire btn_space,
    output reg [7:0] letter,  
    output reg ready,          
    output reg check_dash,
    output reg check_dot,
    output reg check_space,
    output btn_enter_posedge
);

   
    reg [5:0] morse_code;      // Stores the current Morse code sequence 
    reg [3:0] code_length;     // Stores the length of the current Morse code sequence
    
    // Internal signals for debounced button inputs
    wire btn_dot_stable, btn_dash_stable, btn_enter_stable, btn_space_stable;
    wire btn_dot_posedge, btn_dash_posedge, btn_space_posedge;
    
    // Instantiate debouncer for each button
    debounce db_dot(
        .clk(clk),
        .rst(rst),
        .btn(btn_dot),
        .btn_stable(btn_dot_stable),
        .btn_stable_posedge(btn_dot_posedge)
    );
    
    debounce db_dash(
        .clk(clk),
        .rst(rst),
        .btn(btn_dash),
        .btn_stable(btn_dash_stable),
        .btn_stable_posedge(btn_dash_posedge)
    );

    debounce db_enter(
        .clk(clk),
        .rst(rst),
        .btn(btn_enter),
        .btn_stable(btn_enter_stable),
        .btn_stable_posedge(btn_enter_posedge)
    );
    
    debounce db_space(
        .clk(clk),
        .rst(rst),
        .btn(btn_space),
        .btn_stable(btn_space_stable),
        .btn_stable_posedge(btn_space_posedge)
    );  
    
    initial begin 
           morse_code = 6'b000000;
            code_length = 0;
            letter = 8'b00000000;
            ready = 0;
            check_dot=0;
            check_dash=0;
            check_space=0;
    end
     
    always@(negedge clk) begin
    if(rst) begin
        morse_code = 6'b000000;
        code_length = 0;
        letter = 8'b00000000;
        ready = 0;
        check_dot=0;
        check_dash=0;
        check_space=0;
    end else begin
        if(btn_dot_posedge)begin
            morse_code = (morse_code << 1);
            morse_code[0] = 0;
            code_length = code_length + 1;
            check_dot=1;
            ready <= 0;
        end
        else if (btn_dash_posedge) begin
            morse_code = (morse_code << 1);
            morse_code[0] = 1;
            code_length= code_length + 1;
            check_dash =1;
            ready <= 0;

        end
        else if (btn_space_posedge) begin
            morse_code <= 6'b000000;
            code_length <= 0;
            letter = 8'b11111111;
            check_space = 1; 
        end 
        else if (btn_enter_posedge)begin
            if (morse_code == 6'b000001 && code_length == 4'b0010) begin
                letter = "A";
                end
            else if (morse_code == 6'b001000 && code_length == 4'b0100) begin
                letter = "B";
                end
            else if (morse_code == 6'b001010 && code_length == 4'b0100) begin
                letter = "C";
                end
            else if (morse_code == 6'b000100 && code_length == 4'b0011) begin
                letter = "D";
                end
            else if (morse_code == 6'b000000 && code_length == 4'b0001) begin
                letter = "E";
                end
            else if (morse_code == 6'b000010 && code_length == 4'b0100) begin
                letter = "F";
                end
            else if (morse_code == 6'b000110 && code_length == 4'b0011) begin
                letter = "G";
                end
            else if (morse_code == 6'b000000 && code_length == 4'b0100) begin
                letter = "H";
                end
            else if (morse_code == 6'b000000 && code_length == 4'b0010) begin
                letter = "I";
                end
            else if (morse_code == 6'b000111 && code_length == 4'b0100) begin
                letter = "J";
                end
            else if (morse_code == 6'b000101 && code_length == 4'b0011) begin
                letter = "K";
                end
            else if (morse_code == 6'b000100 && code_length == 4'b0100) begin
                letter = "L";
                end
            else if (morse_code == 6'b000011 && code_length == 4'b0010) begin
                letter = "M";
                end
            else if (morse_code == 6'b000010 && code_length == 4'b0010) begin
                letter = "N";
                end
            else if (morse_code == 6'b000111 && code_length == 4'b0011) begin
                letter = "O";
                end
           else if (morse_code == 6'b000110 && code_length == 4'b0100) begin
                letter = "P";
                end
           else if (morse_code == 6'b001101 && code_length == 4'b0100) begin
                letter = "Q";
                end
            else if (morse_code == 6'b000010 && code_length == 4'b0011) begin
                letter = "R";
                end
            else if (morse_code == 6'b000000 && code_length == 4'b0011) begin
                letter = "S";
                end
            else if (morse_code == 6'b000001 && code_length == 4'b0001) begin
                letter = "T";
                end
            else if (morse_code == 6'b000001 && code_length == 4'b0011) begin
                letter = "U";
                end
            else if (morse_code == 6'b000001 && code_length == 4'b0100) begin
                letter = "V";
                end
            else if (morse_code == 6'b000011 && code_length == 4'b0011) begin
                letter = "W";
                end
           else if (morse_code == 6'b001001 && code_length == 4'b0100) begin
                letter = "X";
                end
           else if (morse_code == 6'b001011 && code_length == 4'b0100) begin
                letter = "Y";
                end
           else if (morse_code == 6'b001100 && code_length == 4'b0100) begin
                letter = "Z";
                end
            else if (morse_code == 6'b001111 && code_length == 4'b0100) begin
                letter = 8'b00000000;
                end
            ready <= 1;
            morse_code <= 6'b000000;
            code_length <= 0;
        end
        end    
    end   
    endmodule

