`timescale 1ns / 1ps

// Takes two matrices and returns the resultant matrix's value at index

module MatrixMultiplier
    #(parameter WIDTH=32,      // Size of each element in vector
      parameter MATRIX_DIMS=3) // Dimensions of vector(
    (input [WIDTH-1:0] M_A[MATRIX_DIMS-1:0][MATRIX_DIMS-1:0],
     input [WIDTH-1:0] M_B[MATRIX_DIMS-1:0][MATRIX_DIMS-1:0],
     input  [ 3:0] C_index, // TODO Size C_index appropriately
     output [WIDTH-1:0] C
    );
    
    logic [WIDTH-1:0] col [MATRIX_DIMS-1:0];
    
    genvar i;
    generate // Multiply each corresponding element
        for (i = 0; i < MATRIX_DIMS; i = i + 1) begin
            assign col[i] = M_B[i][C_index % MATRIX_DIMS];
        end
    endgenerate
    
    DotProduct #(WIDTH, MATRIX_DIMS) dp(
        M_A[C_index / MATRIX_DIMS], col, C);
        
endmodule
