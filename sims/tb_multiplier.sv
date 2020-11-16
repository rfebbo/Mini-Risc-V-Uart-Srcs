`timescale 1ns/10ps
 
module m_ext_test;
  // inputs to the DUT are of type reg
  reg        clk    = 1'b0;
  reg        rst    = 1'b0;
  reg [31:0] mulsel = 3'b001;
  reg [31:0] a;
  reg [31:0] b;
 
  // outputs from the DUT are of type wire
  wire [31:0] res;
  
  initial begin
    $display($time, " << Starting the Simulation >> ");
    #100 mulsel = 3'b001;
    #100 mulsel = 3'b010;
    #100 mulsel = 3'b011;
    #100 mulsel = 3'b100;
  end // initial begin
  
  initial begin
    #100 a = 32'h00000009;
    #100 a = 32'hFFFFFFFF;
    #100 a = 32'hFFFFFFFC;
    #100 a = 32'h0001869F;
  end // initial begin
  
  initial begin
    #100 b = 32'h00000003;
    #100 b = 32'h00000001;
    #100 b = 32'h00000003;
    #100 b = 32'h000F423F;
  end // initial begin
 
  // Make operands randomize values
  always begin
    #2 clk = ~clk;
  end
 
  // This is the Design Under Test (DUT)
  Multiplier mul
  (
    .clk(clk),
    .rst(rst),
    .mulsel(mulsel),
    .a(a),
    .b(b),
    .res(res)
  );
endmodule // test
