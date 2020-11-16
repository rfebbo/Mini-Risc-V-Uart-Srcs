module Multiplier
(
  // Inputs
  input         clk,
  input         rst,
  input  [3:0]  mulsel,
  input  [31:0] a,
  input  [31:0] b,
  output [31:0] res
);

  reg  [32:0] a_valid;
  reg  [32:0] b_valid;
  reg  [32:0] op_a;
  reg  [32:0] op_b;
  reg         high_bits;
  wire [64:0] full_res;

  wire mul = (mulsel == 3'b001) ||
             (mulsel == 3'b010) ||
             (mulsel == 3'b011) ||
             (mulsel == 3'b100);

  always_comb
  begin
    if (mulsel == 3'b011)
    begin
      op_a = {a[31], a[31:0]};
      op_b = {1'b0, b[31:0]};
    end
    else if (mulsel == 3'b010)
    begin
      op_a = {a[31], a[31:0]};
      op_b = {b[31], b[31:0]};
    end
    else
    begin
      op_a = {1'b0, a[31:0]};
      op_b = {1'b0, b[31:0]};
    end
  end

  always @(posedge clk or posedge rst)
  begin
    if (rst)
    begin
      a_valid <= 31'b0;
      b_valid <= 31'b0;
      high_bits <= 1'b0;
    end
    else if (mul)
    begin
      a_valid <= op_a;
      b_valid <= op_b;
      high_bits <= ~(mulsel == 3'b001);
    end
    else
    begin
        a_valid <= 31'b0;
        b_valid <= 31'b0;
        high_bits <= 1'b0;
    end
  end

  assign full_res = {{32{a_valid[32]}}, a_valid}*{{32{b_valid[32]}}, b_valid};
  assign res = high_bits ? full_res[63:32] : full_res[31:0];
endmodule
