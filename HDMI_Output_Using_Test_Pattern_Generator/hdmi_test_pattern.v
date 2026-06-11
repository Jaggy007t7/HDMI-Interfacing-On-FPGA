`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jageshwar
// 
// Create Date: 04.06.2026 22:01:57
// Design Name: 
// Module Name: hdmi_test_pattern
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

module hdmi_test_pattern(
    input wire pix_clk,       // 74.25 MHz
    input wire rst,

    output reg [23:0] rgb,
    output reg hsync,
    output reg vsync,
    output reg de
);

// 720p Timing Parameters
localparam H_ACTIVE = 1280;
localparam H_FP     = 110;
localparam H_SYNC   = 40;
localparam H_BP     = 220;
localparam H_TOTAL  = 1650;

localparam V_ACTIVE = 720;
localparam V_FP     = 5;
localparam V_SYNC   = 5;
localparam V_BP     = 20;
localparam V_TOTAL  = 750;

// Counters
reg [11:0] hcount = 0;
reg [11:0] vcount = 0;

// Horizontal Counter
always @(posedge pix_clk) begin
    if(rst)
        hcount <= 0;
    else begin
        if(hcount == H_TOTAL - 1)
            hcount <= 0;
        else
            hcount <= hcount + 1;
    end
end

// Vertical Counter
always @(posedge pix_clk) begin
    if(rst)
        vcount <= 0;
    else begin
        if(hcount == H_TOTAL - 1) begin
            if(vcount == V_TOTAL - 1)
                vcount <= 0;
            else
                vcount <= vcount + 1;
        end
    end
end

// HSYNC
always @(posedge pix_clk) begin
    hsync <= ~((hcount >= (H_ACTIVE + H_FP)) &&
               (hcount <  (H_ACTIVE + H_FP + H_SYNC)));
end

// VSYNC
always @(posedge pix_clk) begin
    vsync <= ~((vcount >= (V_ACTIVE + V_FP)) &&
               (vcount <  (V_ACTIVE + V_FP + V_SYNC)));
end

// Data Enable
always @(posedge pix_clk) begin
    de <= (hcount < H_ACTIVE) && (vcount < V_ACTIVE);
end

// Color Bars
always @(posedge pix_clk) begin
    if(de) begin

        if(hcount < 160)
            rgb <= 24'hFF0000; // Red

        else if(hcount < 320)
            rgb <= 24'h00FF00; // Green

        else if(hcount < 480)
            rgb <= 24'h0000FF; // Blue

        else if(hcount < 640)
            rgb <= 24'hFFFF00; // Yellow

        else if(hcount < 800)
            rgb <= 24'h00FFFF; // Cyan

        else if(hcount < 960)
            rgb <= 24'hFF00FF; // Magenta

        else if(hcount < 1120)
            rgb <= 24'hFFFFFF; // White

        else
            rgb <= 24'h000000; // Black

    end
    else
        rgb <= 24'h000000;
end

endmodule
