`timescale 1ns / 1ps

module DotProduct
    #(parameter WIDTH=8)
    (input  [WIDTH-1:0] A0,
     input  [WIDTH-1:0] A1,
     input  [WIDTH-1:0] A2,
     input  [WIDTH-1:0] B0,
     input  [WIDTH-1:0] B1,
     input  [WIDTH-1:0] B2,
     output [WIDTH-1:0] C0
    );
    
    assign C0 = (A0 * B0) + (A1 * B1) + (A2 * B2);
endmodule
