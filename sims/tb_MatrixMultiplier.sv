`timescale 1ns / 1ps

module tb_MatrixMulitplier();

    logic [31:0] A[2:0][2:0];
    logic [31:0] B[2:0][2:0];
    logic [3:0]  C_index;
    logic [31:0] C_value;

    MatrixMultiplier #(32, 3) mm0(A, B, C_index, C_value);
    
    // Run tests
    initial begin
        A[0][0] = 1;
        A[0][1] = 2;
        A[0][2] = 3;
        $display($time, " A[0] = [%h, %h, %h]",
            A[0][0], A[0][1], A[0][2]);
            
        A[1][0] = 3;
        A[1][1] = 4;
        A[1][2] = 2;
        $display($time, " A[1] = [%h, %h, %h]",
            A[1][0], A[1][1], A[1][2]);
            
        A[2][0] = 3;
        A[2][1] = 2;
        A[2][2] = 1;
        $display($time, " A[2] = [%h, %h, %h]",
            A[2][0], A[2][1], A[2][2]);
            
            
            
        B[0][0] = 1;
        B[0][1] = 1;
        B[0][2] = 1;
        $display($time, " B[0] = [%h, %h, %h]",
            B[0][0], B[0][1], B[0][2]);
            
        B[1][0] = 3;
        B[1][1] = 4;
        B[1][2] = 2;
        $display($time, " B[1] = [%h, %h, %h]",
            B[1][0], B[1][1], B[1][2]);
            
        B[2][0] = 3;
        B[2][1] = 2;
        B[2][2] = 1;
        $display($time, " B[2] = [%h, %h, %h]",
            B[2][0], B[2][1], B[2][2]);
        
        
        
        //   [[1,2,3],[3,4,2],[3,2,1]]
        // * [[1,1,1],[3,4,2],[3,2,1]]
        // = [[16,15,8],[21,23,13],[12,13,8]]
        for (int i = 0; i < 9; i = i + 1) begin
            C_index = i;
            #5;
            $display($time, " C_value = %h", C_value);
            #5;
        end
    end

endmodule
