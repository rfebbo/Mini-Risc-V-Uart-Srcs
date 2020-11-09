`timescale 1ns / 1ps

module LAA(
    input  logic [4:0] addr, // A or B (1 bit), addr (4 bits), all 1s to multiply
    input  logic [31:0] data_in, // Data to be written
    input  logic clk,
    input  logic operate,
    input  logic reset, // Reset all registers to 0
    output logic [31:0] data_out // Output of register at current address
    );
    
    logic write_clock;
    logic [31:0] A00_out, A01_out, A02_out, A10_out, A11_out, A12_out, A20_out, A21_out, A22_out;
    logic [31:0] B00_out, B01_out, B02_out, B10_out, B11_out, B12_out, B20_out, B21_out, B22_out;
    logic [31:0] C00_out, C01_out, C02_out, C10_out, C11_out, C12_out, C20_out, C21_out, C22_out;
    
    assign write_clock = clk & operate;
    
    // Matrix A
    Register #(32) A00(write_clock, addr == 5'b00000 || addr == 5'b11111, reset, addr == 5'b11111 ? C00_out : data_in, A00_out);
    Register #(32) A01(write_clock, addr == 5'b00001 || addr == 5'b11111, reset, addr == 5'b11111 ? C01_out : data_in, A01_out);
    Register #(32) A02(write_clock, addr == 5'b00010 || addr == 5'b11111, reset, addr == 5'b11111 ? C02_out : data_in, A02_out);
    
    Register #(32) A10(write_clock, addr == 5'b00011 || addr == 5'b11111, reset, addr == 5'b11111 ? C10_out : data_in, A10_out);
    Register #(32) A11(write_clock, addr == 5'b00100 || addr == 5'b11111, reset, addr == 5'b11111 ? C11_out : data_in, A11_out);
    Register #(32) A12(write_clock, addr == 5'b00101 || addr == 5'b11111, reset, addr == 5'b11111 ? C12_out : data_in, A12_out);
    
    Register #(32) A20(write_clock, addr == 5'b00110 || addr == 5'b11111, reset, addr == 5'b11111 ? C20_out : data_in, A20_out);
    Register #(32) A21(write_clock, addr == 5'b00111 || addr == 5'b11111, reset, addr == 5'b11111 ? C21_out : data_in, A21_out);
    Register #(32) A22(write_clock, addr == 5'b01000 || addr == 5'b11111, reset, addr == 5'b11111 ? C22_out : data_in, A22_out);
    
    // Matrix B
    Register #(32) B00(write_clock, addr == 5'b10000, reset, data_in, B00_out);
    Register #(32) B01(write_clock, addr == 5'b10001, reset, data_in, B01_out);
    Register #(32) B02(write_clock, addr == 5'b10010, reset, data_in, B02_out);
    
    Register #(32) B10(write_clock, addr == 5'b10011, reset, data_in, B10_out);
    Register #(32) B11(write_clock, addr == 5'b10100, reset, data_in, B11_out);
    Register #(32) B12(write_clock, addr == 5'b10101, reset, data_in, B12_out);
    
    Register #(32) B20(write_clock, addr == 5'b10110, reset, data_in, B20_out);
    Register #(32) B21(write_clock, addr == 5'b10111, reset, data_in, B21_out);
    Register #(32) B22(write_clock, addr == 5'b11000, reset, data_in, B22_out);
    
    // Matrix Multiplier
    MatrixMultiplier mm0(
        A00_out, A01_out, A02_out, A10_out, A11_out, A12_out, A20_out, A21_out, A22_out,
        B00_out, B01_out, B02_out, B10_out, B11_out, B12_out, B20_out, B21_out, B22_out,
        C00_out, C01_out, C02_out, C10_out, C11_out, C12_out, C20_out, C21_out, C22_out
        );
    
    // Translate address to data out
    always_comb begin
        case (addr)
            5'b00000: data_out = A00_out; // A00
            5'b00001: data_out = A01_out; // A01
            5'b00010: data_out = A02_out; // A02
            
            5'b00011: data_out = A10_out; // A10
            5'b00100: data_out = A11_out; // A11
            5'b00101: data_out = A12_out; // A12
            
            5'b00110: data_out = A20_out; // A20
            5'b00111: data_out = A21_out; // A21
            5'b01000: data_out = A22_out; // A22
            
            5'b10000: data_out = B00_out; // B00
            5'b10001: data_out = B01_out; // B01
            5'b10010: data_out = B02_out; // B02
            
            5'b10011: data_out = B10_out; // B10
            5'b10100: data_out = B11_out; // B11
            5'b10101: data_out = B12_out; // B12
            
            5'b10110: data_out = B20_out; // B20
            5'b10111: data_out = B21_out; // B21
            5'b11000: data_out = B22_out; // B22
            
            default: data_out = 32'h00000000;
        endcase
    end
endmodule
