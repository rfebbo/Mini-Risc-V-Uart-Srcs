`timescale 1ns / 1ps

// Takes two matrices and returns the resultant matrix's value at index

module MatrixVectorMultiplier
    #(parameter WIDTH=32,      // Size of each element in vector
      parameter MATRIX_DIMS=3) // Dimensions of vector
    (input  [WIDTH-1:0] M_A[MATRIX_DIMS-1:0][MATRIX_DIMS-1:0],
     input  [WIDTH-1:0] V_B[MATRIX_DIMS-1:0],
     output [WIDTH-1:0] V_C[MATRIX_DIMS-1:0]
    );
    
    // Generate dot products
    // e.g. 3x3 * 3x1 = 3x1
    // V_C[0] = DP(M_A[0], V_B)
    // V_C[1] = DP(M_A[1], V_B)
    // V_C[2] = DP(M_A[2], V_B)
    
    genvar i;
    generate // Multiply each corresponding element
        for (i = 0; i < MATRIX_DIMS; i = i + 1) begin
            DotProduct #(WIDTH, MATRIX_DIMS) dp(M_A[i], V_B, V_C[i]);
        end
    endgenerate
    
endmodule
