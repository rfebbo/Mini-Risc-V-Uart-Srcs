`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 12:20:04 PM
// Design Name: 
// Module Name: mux_chaos
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


module mux_chaos(
    input  logic       a,
    input  logic       b,
    input  logic       sel,
    input  logic [5:0] key,
    output logic       y
    );
    
logic c, d, not_sel;

chao_2x1 gate1(c, {a, not_sel},key);
//not gate0(not_sel, sel);
//and gate2(d, b, sel);
//or gate3(y, c, d);
assign  not_sel = ~sel;
assign  d       = b & sel;
assign  y       = c | d;    
endmodule
