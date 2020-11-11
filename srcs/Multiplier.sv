module Multiplier
(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [1:0]  mulsel,
    output logic [31:0] res,
);
    reg        a_sign   = 1'b0;
    reg        b_sign   = 1'b0;
    wire [63:0] op_a    = 64'h0000000000000000;
    wire [63:0] op_b    = 64'h0000000000000000;
    wire [63:0] mul_res = 64'h0000000000000000;

    always @(posedge clk_i)
    begin
        a_sign   <= (mulsel == 2'b01) || (mulsel == 2'b10);
        b_sign   <= (mulsel == 2'b01);
    end

    assign op_a = {{32{a_sign & a[31]}}, a};
    assign op_b = {{32{b_sign & b[31]}}, b};
    assign mul_res = op_a * op_b;

    always @*
    begin
        case(mulsel)
            2'b00:   res = mul_res[31:0];
            2'b01:   res = mul_res[63:32];
            2'b10:   res = mul_res[63:32];
            2'b11:   res = mul_res[63:32];
            default: res = 32'h0;
        endcase
    end
endmodule: Multiplier