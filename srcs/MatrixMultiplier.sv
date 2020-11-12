`timescale 1ns / 1ps

// Takes two matrices and returns the resultant matrix's value at index

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
    input  [ 3:0] C_index,
    output [31:0] C
    );
    
    logic [31:0] dp_A0, dp_A1, dp_A2, dp_B0, dp_B1, dp_B2;
    
    DotProduct #(32) dp(dp_A0, dp_A1, dp_A2, dp_B0, dp_B1, dp_B2, C);
    
    // Select from Matrix A
    always_comb begin
        case (C_index)
            4'b0000,
            4'b0001,
            4'b0010:
                begin
                dp_A0 = A00;
                dp_A1 = A01;
                dp_A2 = A02;
                end
            
            4'b0011,
            4'b0100,
            4'b0101:
                begin
                dp_A0 = A10;
                dp_A1 = A11;
                dp_A2 = A12;
                end
            
            4'b0110,
            4'b0111,
            4'b1000:
                begin
                dp_A0 = A20;
                dp_A1 = A21;
                dp_A2 = A22;
                end
                
            default:
                begin
                dp_A0 = 32'h0000;
                dp_A1 = 32'h0000;
                dp_A2 = 32'h0000;
                end
        endcase
    end
    
    // Select from Matrix B
    always_comb begin
        case (C_index)
            4'b0000,
            4'b0011,
            4'b0110:
                begin
                dp_B0 = B00;
                dp_B1 = B10;
                dp_B2 = B20;
                end
            
            4'b0001,
            4'b0100,
            4'b0111:
                begin
                dp_B0 = B01;
                dp_B1 = B11;
                dp_B2 = B21;
                end
            
            4'b0010,
            4'b0101,
            4'b1000:
                begin
                dp_B0 = B02;
                dp_B1 = B12;
                dp_B2 = B22;
                end
                
            default:
                begin
                dp_B0 = 32'h0000;
                dp_B1 = 32'h0000;
                dp_B2 = 32'h0000;
                end
        endcase
    end
    
endmodule
