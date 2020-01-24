`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2019 10:07:43 AM
// Design Name: 
// Module Name: tb_rvtop
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



module tb_rvtop();

logic clk, Rst, debug, rx, prog;
logic[ 4:0] debug_input; 
logic tx, clk_out; 
logic [6:0] sev_out;
logic [7:0] an;
logic [15:0] led; 
logic [95:0] key;

assign key[95:48]=48'h3cf3cf3cf3cf;
assign key[47:24]=24'h30c30c;
assign key[23:12]=12'hbae;
assign key[11:0]=12'h3cf;
//assign key[95:48]=48'haaaaaaaaaaaa;
//assign key[47:24]=24'h000000;
//assign key[23:12]=12'h000;
//assign key[11:0] = 12'h000;
rv_top dut(.*); 

always #5 clk=!clk; 

initial begin
    clk = 0;
    Rst = 1; 
    debug = 0;
    rx = 1; 
    prog = 0;
    debug_input = 0; 
    #10;
    Rst=0;
    
//    #9000;
//    rx = 0; //start bit
//    #9000;
//    rx = 1; //d0
//    #9000;
//    rx = 0; //d1
//    #9000;
//    rx = 1; //d2
//    #9000;
//    rx = 0; //d3
//    #9000;
//    rx = 1; //d4
//    #9000;
//    rx = 0; //d5
//    #9000;
//    rx = 1; //d6
//    #9000;
//    rx = 0; //d7
//    #9000;
//    rx = 1; //stop bit
    
//    #1500
    
//    debug_input=5'b00001;
//    #10
//    debug_input=5'b00010;
//    #10
//    debug_input=5'b00011;

end

endmodule
