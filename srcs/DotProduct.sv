`timescale 1ns / 1ps

module DotProduct
    #(parameter WIDTH=32,      // Size of each element in vector
      parameter MATRIX_DIMS=3) // Dimensions of vector
    (input  [WIDTH-1:0] A[MATRIX_DIMS-1:0],
     input  [WIDTH-1:0] B[MATRIX_DIMS-1:0],
     output [WIDTH-1:0] C
    );

    logic [WIDTH-1:0] P[MATRIX_DIMS-1:0]; // Products (A0*B0, A1*B1, A2*B2, etc.)
    logic [WIDTH-1:0] S[MATRIX_DIMS-1:0]; // Partial sums of products, S[N] = P[N] + S[N+1]

    //assign C0 = (A0 * B0) + (A1 * B1) + (A2 * B2);
    genvar i;
    generate // Multiply each corresponding element
        for (i = 0; i < MATRIX_DIMS; i = i + 1) begin
            assign P[i] = A[i] * B[i];
        end
    endgenerate
    generate // Sum all products
        for (i = 0; i < MATRIX_DIMS - 1; i = i + 1) begin
            assign S[i] = P[i] + S[i + 1];
            // Sum[0] = Prod[0] + Sum[1]
            // Sum[1] = Prod[1] + Sum[2]
            // Sum[2] = Prod[2] + Sum[3]
            // ...
            // Sum[6] = Prod[6] + Sum[7]
            // Sum[7] = Prod[7]         (handled outside of generate loop)
        end
    endgenerate

    assign C = S[0]; // Set output to total sum
    assign S[MATRIX_DIMS-1] = P[MATRIX_DIMS-1]; // Set last sum to only the last product

endmodule
