`timescale 1ns / 1ps

module MatrixMultiplier(
    input  [31:0] A00,
    input  [31:0] A01,
    input  [31:0] A02,
    input  [31:0] A10,
    input  [31:0] A11,
    input  [31:0] A12,
    input  [31:0] A20,
    input  [31:0] A21,
    input  [31:0] A22,
    input  [31:0] B00,
    input  [31:0] B01,
    input  [31:0] B02,
    input  [31:0] B10,
    input  [31:0] B11,
    input  [31:0] B12,
    input  [31:0] B20,
    input  [31:0] B21,
    input  [31:0] B22,
    output [31:0] C00,
    output [31:0] C01,
    output [31:0] C02,
    output [31:0] C10,
    output [31:0] C11,
    output [31:0] C12,
    output [31:0] C20,
    output [31:0] C21,
    output [31:0] C22
    );
    
    assign C00 = (A00 * B00) + (A01 * B10) + (A02 * B20);
    assign C01 = (A00 * B01) + (A01 * B11) + (A02 * B21);
    assign C02 = (A00 * B02) + (A01 * B12) + (A02 * B22);
    
    assign C10 = (A10 * B00) + (A11 * B10) + (A12 * B20);
    assign C11 = (A10 * B01) + (A11 * B11) + (A12 * B21);
    assign C12 = (A10 * B02) + (A11 * B12) + (A12 * B22);
    
    assign C20 = (A20 * B00) + (A21 * B10) + (A22 * B20);
    assign C21 = (A20 * B01) + (A21 * B11) + (A22 * B21);
    assign C22 = (A20 * B02) + (A21 * B12) + (A22 * B22);
endmodule
