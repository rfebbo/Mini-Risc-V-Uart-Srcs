`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 09:46:39 PM
// Design Name: 
// Module Name: add_sub
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


module add_sub_chaos
    
    (
    input  logic     [width-1:0]           a,
    input  logic     [width-1:0]           b,
    input  logic                           c_in,
    input  logic     [keysize*keyset-1:0]  key,
    output logic     [width-1:0]           sum
    //output logic                           c_out
    );
    
   parameter width   = 32;
   parameter keysize = 6;
   parameter keyset =  2;//no. of chaos gate with unique key set used
   logic [width-1:0] b_xor;
   logic [width-2:0] cout_imd;
   logic c_out;
   
   
//   xor gate0(b_xor[0], c_in, b[0]);
   assign b_xor[0] = c_in ^ b[0];
   adder_chaos a0(.a(a[0]), .b(b_xor[0]), .c_in(c_in),.key(key[(keysize*keyset/2)-1:0]), .c_out(cout_imd[0]), .sum(sum[0]));
   
    genvar ii;
    generate
       for (ii=1; ii<width-1; ii=ii+1) 
         begin
           //xor gate1(b_xor[ii], c_in, b[ii]);
           assign b_xor[ii] = c_in ^ b[ii];
           
           if(ii<width/2)
           
               adder_chaos full_adder_chaos_inst
                   ( 
                     .a(a[ii]),
                     .b(b_xor[ii]),
                     .c_in(cout_imd[ii-1]),
                     .key(key[(keysize*keyset/2)-1:0]),
                     .sum(sum[ii]),
                     .c_out(cout_imd[ii])
                     );
            else
                          
                adder_chaos full_adder_chaos_inst
                    ( 
                      .a(a[ii]),
                      .b(b_xor[ii]),
                      .c_in(cout_imd[ii-1]),
                      .key(key[(keysize*keyset-1):(keysize*keyset/2)]),
                      .sum(sum[ii]),
                      .c_out(cout_imd[ii])
                      );
         end
     endgenerate
   
 
  
   //xor gate31(b_xor[width], c_in, b[width]);
   assign b_xor[width-1] = c_in ^ b[width-1];            
   adder_chaos a31(.a(a[width-1]), .b(b_xor[width-1]), .c_in(cout_imd[width-2]),.key(key[(keysize*keyset-1):(keysize*keyset/2)]), .c_out(c_out), .sum(sum[width-1]));
endmodule
