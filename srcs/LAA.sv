`timescale 1ns / 1ps

typedef enum bit[1:0] {
    NONE=0, READ=1, WRITE=2, MULTIPLY=3
    } LAA_opcode;
    
interface LAA_bus (
    input  logic clk,
    input  logic rst // Reset all registers to 0
    );
    LAA_opcode opcode;
    logic [4:0] addr; // 00000-01000 for A, 01001-10001 for B; 11111 = control register ( 1 if ready )
    logic [31:0] data_in; // Data to be written
    logic [31:0] data_out; // Output of last read register
endinterface

module LAA(LAA_bus bus);
    // A: 00000, 00001, 00010, 00011, 00100, 00101, 00110, 00111, 01000 ( 0- 8)
    //       00,    01,    02,    10,    11,    12,    20,    21,    22
    // B: 01001, 01010, 01011, 01100, 01101, 01110, 01111, 10000, 10001 ( 9-17)
    //       00,    01,    02,    10,    11,    12,    20,    21,    22
    // C: 10010, 10011, 10100, 10101, 10110, 10111, 11000, 11001, 11010 (18-26, not addressible)
    //       00,    01,    02,    10,    11,    12,    20,    21,    22
    // Control: 11111 (27)
    
    logic ready;
    logic [31:0] matrices [27:0]; // 28 registers (9 ea. for A, B, & C; 1 for data_out)
    logic [3:0] stage;
    logic [31:0] dp_result;
    
    assign bus.data_out = matrices[27];
    assign ready = stage == 4'b0000;
    
    always_ff @(posedge bus.clk) begin
        if (bus.rst) begin
            // Reset
            for (int m = 0; m <= $size(matrices); m++)
                matrices[m] <= 32'h0000;
            stage = 4'b0000;
        end
        else if (bus.opcode == MULTIPLY || stage != 4'b0000) begin
            $display($time, "   Dot product result:", stage, dp_result);
            matrices[18 + stage] <= dp_result;
            if (stage == 4'b1001) begin
                // Finish multiplication
                stage <= 4'b0000;
                $display($time, "   Writing results back to matrix A");
                for (int m = 0; m < 9; m++) // A <= C
                    matrices[m] <= matrices[m + 18];
            end else begin
                // Begin/continue multiplication
                stage <= stage + 1;
            end
        end
        else if (bus.opcode == WRITE && bus.addr >= 5'b00000 && bus.addr <= 5'b10001)
            // Write
          matrices[bus.addr] <= bus.data_in;
        else if (bus.opcode == READ  && bus.addr >= 5'b00000 && bus.addr <= 5'b10001)
            // Read
            matrices[27] <= matrices[bus.addr];
        else if (bus.opcode == READ && bus.addr == 5'b11111)
            // Read control register
            matrices[27] <= ready;
    end
    
    MatrixMultiplier mm0(
        //A00_out, A01_out, A02_out, A10_out, A11_out, A12_out, A20_out, A21_out, A22_out,
        matrices[ 0], matrices[ 1], matrices[ 2], matrices[ 3], matrices[ 4], matrices[ 5], matrices[ 6], matrices[ 7], matrices[ 8], 
        //B00_out, B01_out, B02_out, B10_out, B11_out, B12_out, B20_out, B21_out, B22_out,
        matrices[ 9], matrices[10], matrices[11], matrices[12], matrices[13], matrices[14], matrices[15], matrices[16], matrices[17],
        stage, dp_result
        );
endmodule
