module Divider
(
  input         clk,
  input         rst,
  input  [2:0]  divsel,
  input  [31:0] a,
  input  [31:0] b,
  output        ready,
  output [31:0] res
);

  reg [31:0] dividend;
  reg [62:0] divisor;
  reg [31:0] divid;
  reg [62:0] divis;
  reg [31:0] quotient;
  reg [31:0] mask;
  reg        div_inst;
  reg        busy;
  reg        invert_res;
  reg        ready_s;
  reg [31:0] result;
  reg        count;

  wire div  = (divsel == 3'b001); //div
  wire divu = (divsel == 3'b010); //divu
  wire rem  = (divsel == 3'b011); //rem
  wire remu = (divsel == 3'b100); //remu

  wire divrem    = div || divu || rem || remu;
  wire div_op    = div || divu;

  always_comb
  begin
    case (divsel)
      3'b001:
      begin
        divid <= a[31] ? -a : a;
        divis <= b[31] ? {-b, 31'b0} : {b, 31'b0};
      end
      3'b011:
      begin
        divid <= a[31] ? -a : a;
        divis <= b[31] ? {-b, 31'b0} : {b, 31'b0};
      end
      default:
      begin
        divid <= a;
        divis <= {b, 31'b0};
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
    else if (rst || !divrem)
    begin
      busy         <= 1'b0;
      dividend     <= 32'b0;
      divisor      <= 63'b0;
      invert_res   <= 1'b0;
      quotient     <= 32'b0;
      mask         <= 32'b0;
      div_inst     <= 1'b0;
      ready_s      <= 1'b0;
      count        <= 1'b0;
    end
    else if (busy)
    begin
      if (divisor <= {31'b0, dividend})
      begin
        dividend = dividend - divisor[31:0];
        quotient = quotient | mask;
      end
  
      divisor = divisor >> 1'b1;
      mask    = mask >> 1'b1;
      ready_s = !(|mask);
      count   = !(|mask);
      busy    = |mask;
    end
    else
    begin
      div_inst   <= div_op;
      quotient   <= 32'b0;
      mask       <= 32'h80000000;
      dividend   <= divid;
      divisor    <= divis;
      invert_res <= (div && (a[31] != b[31]) && |b) || (rem && a[31]);
      busy       <= 1'b1;
    end
  end

  always_comb
  begin
    result = 32'b0;

    if (div_inst)
      result = invert_res ? -quotient : quotient;
    else
      result = invert_res ? -dividend : dividend;
  end

  assign ready = ready_s;
  assign res   = result;
endmodule