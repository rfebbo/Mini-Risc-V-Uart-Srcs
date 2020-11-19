module Multiplier
(
  // Inputs
  input         clk,
  input         rst,
  input  [2:0]  mulsel,
  input  [31:0] a,
  input  [31:0] b,
  output        ready,
  output [31:0] res
);

  reg [32:0] a_valid;
  reg [32:0] b_valid;
  reg [32:0] op_a;
  reg [32:0] op_b;
  reg        high_bits;
  reg        busy;
  reg        ready_s;
  reg [64:0] full_res;
  reg        count;

  wire mul = (mulsel == 3'b001) ||
             (mulsel == 3'b010) ||
             (mulsel == 3'b011) ||
             (mulsel == 3'b100);

  always_comb
  begin
    case (mulsel)
      3'b011:
      begin
        op_a = {a[31], a[31:0]};
        op_b = {1'b0, b[31:0]};
      end
      3'b010:
      begin
        op_a = {a[31], a[31:0]};
        op_b = {b[31], b[31:0]};
      end
      default:
      begin
        op_a = {1'b0, a[31:0]};
        op_b = {1'b0, b[31:0]};
      end
    endcase
  end

  always @(posedge clk or posedge rst)
  begin
    if (ready_s)
    begin
      if (count)
        count <= 0;
      else
        ready_s <= 0;
    end
    else if (rst || !mul) // Reset
    begin
      a_valid   <= 32'b0;
      b_valid   <= 32'b0;
      high_bits <= 1'b0;
      busy      <= 1'b0;
      ready_s   <= 1'b0;
      count     <= 1'b0;
      full_res  <= 32'h0;
    end
    else if (busy) // Stage 2: Calculate multiplication.
    begin
      full_res = {{32{a_valid[32]}}, a_valid} * {{32{b_valid[32]}}, b_valid};
      ready_s  = 1'b1;
      count    = 1'b1;
      busy     = 1'b0;
    end
    else // Stage 1: Set operands.
    begin
      a_valid   <= op_a;
      b_valid   <= op_b;
      high_bits <= ~(mulsel == 3'b001);
      busy      <= 1'b1;
    end
  end

  assign ready = ready_s;
  assign res   = high_bits ? full_res[63:32] : full_res[31:0];
endmodule