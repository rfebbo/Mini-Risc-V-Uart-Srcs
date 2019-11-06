`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 11:59:33 AM
// Design Name: 
// Module Name: adder_chaos
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


module adder_chaos(
    input  logic       a,
    input  logic       b,
    input  logic       c_in,
    input  logic [5:0] key,
    output logic       sum,
    output logic       c_out
    );
    logic n1, n2, n3;
    chao_2x1 gate0(n1,{b,a},key);
//    xor gate1(sum, n1, c_in);
//    and gate2(n2, c_in, n1);
//    and gate3(n3, a, b);
//    or gate4(c_out, n2, n3);
    assign sum   = n1 ^ c_in;
    assign n2    = n1 & c_in;
    assign n3    = a  & b;
    assign c_out = n2 | n3;
endmodule
