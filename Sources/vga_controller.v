module vga_controller(
    input clk,
    input rst,
    input btn_enter, // Button to enter a new letter
    input [7:0] letter, // Input for the decoded letter
    output reg h_sync, 
    output reg v_sync, 
    output reg led_on
    );

    localparam TOTAL_WIDTH = 800;
    localparam TOTAL_HEIGHT = 525;
    localparam H_SYNC_COLUMN = 704;
    localparam V_SYNC_LINE = 523;
    localparam CHAR_WIDTH = 8; 
    localparam CHAR_HEIGHT = 16;
    localparam MAX_LETTERS = 50; // Max letters in array 

    reg [10:0] adder_rom;
    wire [7:0] font_rom;  

    reg [11:0] widthPos = 0;
    reg [11:0] heightPos = 0;

    reg [7:0] memory [0:MAX_LETTERS-1]; // array to store letters entered 
    reg [11:0] letter_positions [0:MAX_LETTERS-1]; // Stores x-positions for letters
    reg [6:0] letter_count = 0; // Tracks how many letters are entered
    reg [11:0] current_x_pos = 200; // Current x-position for the next letter

    wire enable = ((widthPos >= 50 && widthPos < 690) && (heightPos >= 33 && heightPos < 513)) ? 1'b1 : 1'b0;
    wire [MAX_LETTERS-1:0] letter_enables;

    integer i;

    // Generate individual letter enable signals for all stored letters
    generate
        genvar idx;
        for (idx = 0; idx < MAX_LETTERS; idx = idx + 1) begin : LETTER_ENABLES
            assign letter_enables[idx] = ((widthPos >= letter_positions[idx] && widthPos < (letter_positions[idx] + CHAR_WIDTH)) && 
                                         (heightPos >= 240 && heightPos < 256));
        end
    endgenerate

    // Adder ROM logic for each character
    always @(*) begin
        adder_rom = 11'h000; // Default value
        for (i = 0; i < MAX_LETTERS; i = i + 1) begin
            if (letter_enables[i]) begin
                case (memory[i])
                    8'b00000000: adder_rom = 11'h2e0; //period 
                    8'b11111111: adder_rom = 11'h000; //space 
                    8'b01000001: adder_rom = 11'h410;
                    8'b01000010: adder_rom = 11'h420;
                    8'b01000011: adder_rom = 11'h430;
                    8'b01000100: adder_rom = 11'h440;
                    8'b01000101: adder_rom = 11'h450;
                    8'b01000110: adder_rom = 11'h460;
                    8'b01000111: adder_rom = 11'h470;
                    8'b01001000: adder_rom = 11'h480;
                    8'b01001001: adder_rom = 11'h490;
                    8'b01001010: adder_rom = 11'h4a0;
                    8'b01001011: adder_rom = 11'h4b0;
                    8'b01001100: adder_rom = 11'h4c0;
                    8'b01001101: adder_rom = 11'h4d0;
                    8'b01001110: adder_rom = 11'h4e0;
                    8'b01001111: adder_rom = 11'h4f0;
                    8'b01010000: adder_rom = 11'h500;
                    8'b01010001: adder_rom = 11'h510;
                    8'b01010010: adder_rom = 11'h520;
                    8'b01010011: adder_rom = 11'h530;
                    8'b01010100: adder_rom = 11'h540;
                    8'b01010101: adder_rom = 11'h550;
                    8'b01010110: adder_rom = 11'h560;
                    8'b01010111: adder_rom = 11'h570;
                    8'b01011000: adder_rom = 11'h580;
                    8'b01011001: adder_rom = 11'h590;
                    8'b01011010: adder_rom = 11'h5a0;
                    default: adder_rom = 11'h000;
                endcase
                adder_rom = adder_rom + (heightPos - 240);
            end
        end
    end

    // Instantiate the font ROM
    ascii_rom rom(.clk(clk), .addr(adder_rom), .data(font_rom));

    // VGA signal generation
    always @(posedge clk) begin
        if (widthPos < TOTAL_WIDTH - 1) begin
            widthPos <= widthPos + 1;
        end else begin
            widthPos <= 0;
            if (heightPos < TOTAL_HEIGHT - 1) begin
                heightPos <= heightPos + 1;
            end else begin
                heightPos <= 0;
            end
        end
    end

    always @(posedge clk) begin
        h_sync <= (widthPos < H_SYNC_COLUMN) ? 1'b1 : 1'b0;
        v_sync <= (heightPos < V_SYNC_LINE) ? 1'b1 : 1'b0;
    end

    // Display logic for enabling LED output
    always @(posedge clk) begin
        if (enable && (|letter_enables)) begin
            led_on <= font_rom[7 - (widthPos % CHAR_WIDTH)];
        end else begin
            led_on <= 1'b0;
        end
    end

    // Logic to display all letters 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            letter_count <= 0;
            current_x_pos <= 200;
            for (i = 0; i < MAX_LETTERS; i = i + 1) begin
                memory[i] <= 8'h00;
                letter_positions[i] <= 0;
            end
        end else if (btn_enter && (letter_count < MAX_LETTERS)) begin
            memory[letter_count] <= letter;
            letter_positions[letter_count] <= current_x_pos;
            letter_count <= letter_count + 1;
            current_x_pos <= current_x_pos + CHAR_WIDTH;
        end
    end

endmodule
