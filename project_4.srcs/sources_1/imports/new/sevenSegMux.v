`timescale 1ns / 1ps
module sevenSegMux (
    input wire blink_clk,
    input blink,
    input wire [3:0] sec10Val,
    input wire [3:0] sec6Val,
    input wire [3:0] min10Val,
    input wire [3:0] min6Val,
    input wire clk_500Hz, 
    output reg [6:0] seg,
    output reg dp,
    output reg [3:0] an
);

reg [1:0] digit_select = 0; 
reg blink_toggle = 0;    

always @(posedge blink_clk) begin
    if (blink) begin
        blink_toggle <= ~blink_toggle; 
    end
end

always @(posedge clk_500Hz) begin
    digit_select <= digit_select + 1;
end

reg [3:0] current_value;
always @(*) begin
    case (digit_select)
        2'b00: current_value = sec10Val;    
        2'b01: current_value = sec6Val;     
        2'b10: current_value = min10Val;    
        2'b11: current_value = min6Val;     
    endcase
end

always @(*) begin
    case (current_value)
        4'b0000: seg = 7'b1000000; // '0' 
        4'b0001: seg = 7'b1111001; // '1'
        4'b0010: seg = 7'b0100100; // '2'
        4'b0011: seg = 7'b0110000; // '3'
        4'b0100: seg = 7'b0011001; // '4'
        4'b0101: seg = 7'b0010010; // '5'
        4'b0110: seg = 7'b0000010; // '6'
        4'b0111: seg = 7'b1111000; // '7'
        4'b1000: seg = 7'b0000000; // '8'
        4'b1001: seg = 7'b0010000; // '9'
        default: seg = 7'b1111111; // Blank
    endcase

    if  (blink && blink_toggle) begin
        seg = 7'b1111111; 
    end
end

always @(*) begin
    an = 4'b1111;  
    an[digit_select] = 0;  
    dp = 1; 
end

endmodule
