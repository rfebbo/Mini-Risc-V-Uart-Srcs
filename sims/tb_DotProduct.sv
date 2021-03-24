`timescale 1ns / 1ps

module tb_DotProduct();

    logic [31:0] A[2:0];
    logic [31:0] B[2:0];
    logic [31:0] C;

    DotProduct #(32, 3) dp0(A, B, C);
    
    // Run tests
    initial begin
        A[0] = 32'h00000009;
        A[1] = 32'h00000002;
        A[2] = 32'h00000007;
        $display($time, " A = [%h, %h, %h]", A[0], A[1], A[2]);
        B[0] = 32'h00000004;
        B[1] = 32'h00000008;
        B[2] = 32'h0000000A;
        $display($time, " B = [%h, %h, %h]", B[0], B[1], B[2]);
        // 9 × 4 + 2 × 8 + 7 × 10 = 122
        #5;
        $display($time, " C = %h", C);
    end

endmodule
