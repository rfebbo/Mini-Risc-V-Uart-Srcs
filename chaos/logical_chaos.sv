`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 11:54:21 PM
// Design Name: 
// Module Name: logical_chaos
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


module logical_chaos(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [11:0] key,
    output logic [31:0] y
    );
parameter width=32;
genvar ii;
generate
    for (ii=0; ii<width; ii++)
    begin
        chao_2x1 gate1(.y(y[ii]), .x({a[ii], b[ii]}),.key(key[(ii/16)*6+5:(ii/16)*6]));
    end
endgenerate
      
endmodule
