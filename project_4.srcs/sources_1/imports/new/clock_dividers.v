`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 03:14:33 PM
// Design Name: 
// Module Name: clock_dividers
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


module clock_dividers(
input wire clk_in,
output reg clk_2Hz,
output reg clk_1Hz,
output reg clk_1_5Hz,
output reg clk_500Hz,
output reg clk_120Hz
    );
reg [31:0] count_2Hz = 0;
reg [31:0] count_1Hz = 0;
reg [31:0] count_1_5Hz = 0;
reg [31:0] count_500Hz = 0;
reg [31:0] count_120Hz = 0;
initial begin
    clk_2Hz<=0;
    clk_1Hz<=0;
    clk_1_5Hz=0;
    clk_500Hz=0;
    clk_120Hz = 0;
end
always @(posedge clk_in)begin
    count_1Hz <= count_1Hz +1;
    if(count_1Hz >= 50000000)begin
        count_1Hz <=0;
        clk_1Hz <= ~clk_1Hz;
    end
end
always @(posedge clk_in)begin
    count_2Hz <= count_2Hz +1;
    if(count_2Hz >= 25000000)begin
        count_2Hz <=0;
        clk_2Hz <= ~clk_2Hz;
    end
end
always @(posedge clk_in)begin
    count_1_5Hz <= count_1_5Hz +1; //actually 4Hz, was 1.5Hz
    if(count_1_5Hz >= 12500000)begin
        count_1_5Hz <=0;
        clk_1_5Hz <= ~clk_1_5Hz;
    end
end
always @(posedge clk_in)begin
    count_500Hz <= count_500Hz +1;
    if(count_500Hz >= 100000)begin
        count_500Hz <=0;
        clk_500Hz <= ~clk_500Hz;
    end
end
always @(posedge clk_in)begin
    count_120Hz <= count_120Hz +1;
    if(count_120Hz >= 416667)begin
        count_120Hz <=0;
        clk_120Hz <= ~clk_120Hz;
    end
end
endmodule
