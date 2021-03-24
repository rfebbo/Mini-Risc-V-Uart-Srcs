`timescale 1ns / 1ps

module tb_MatrixVectorMulitplier();

    logic [31:0] A[2:0][2:0];
    logic [31:0] B[2:0];
    logic [31:0] C[2:0];

    MatrixVectorMultiplier #(32, 3) mv0(A, B, C);
    
    // Run tests
    initial begin
        A[0][0] =  1;
        A[0][1] =  0;
        A[0][2] = -2;
        $display($time, " A[0] = [%h, %h, %h]",
            A[0][0], A[0][1], A[0][2]);
            
        A[1][0] =  0;
        A[1][1] =  3;
        A[1][2] = -1;
        $display($time, " A[1] = [%h, %h, %h]",
            A[1][0], A[1][1], A[1][2]);
            
        A[2][0] =  1;
        A[2][1] =  2;
        A[2][2] =  1;
        $display($time, " A[2] = [%h, %h, %h]",
            A[2][0], A[2][1], A[2][2]);
            
        B[0] =  3;
        B[1] = -1;
        B[2] =  4;
        $display($time, " B = [%h, %h, %h]", B[0], B[1], B[2]);
        
        // [[1,0,-2],[0,3,-1],[1,2,1]] * [3,-1,4] = [-5,-7,5]
        #5;
        $display($time, " C = [%h, %h, %h]", C[0], C[1], C[2]);
    end

endmodule
