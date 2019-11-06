`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 03:55:02 PM
// Design Name: 
// Module Name: tb_chao_2x1
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


module tb_chao_2x1(

    );
reg [1:0] x;
reg [5:0] key;
reg       y;

chao_2x1 uut(.x(x),.key(key),.y(y));

         
 
 
initial begin
    //
    key=6'b101110;
    x=2'b00;
    #20
    x=2'b01;
    #20
    x=2'b10;
    #20
    x=2'b11;
    #20
    //
    key=$random;
    x=2'b00;
    #20
    x=2'b01;
    #20
    x=2'b10;
    #20
    x=2'b11;
    #20
    key=$random;
    x=2'b00;
    #20
    x=2'b01;
    #20
    x=2'b10;
    #20
    x=2'b11;
    #20
    key=$random;
    x=2'b00;
    #20
    x=2'b01;
    #20
    x=2'b10;
    #20
    x=2'b11;  
 end    
endmodule
