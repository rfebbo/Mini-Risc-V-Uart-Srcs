`timescale 1ns/10ps
 
module m_ext_test;
  // inputs to the DUT are of type reg
  reg        clk    = 1'b0;
  reg        rst    = 1'b0;
  reg [2:0]  mulsel = 3'b001;
  reg [31:0] a      = -32'd250000;
  reg [31:0] b      = 32'd280000;
 
  // outputs from the DUT are of type wire
  wire        ready;
  wire [31:0] res;
  
  initial begin
    $display($time, " << Starting the Simulation >> ");
    #100 mulsel = 3'b010;
    #100 mulsel = 3'b011;
    #100 mulsel = 3'b100;
  end // initial begin
  
  initial begin
    #200 a = -32'd4;
  end // initial begin
  
  initial begin
    #200 b = 32'd2;
  end // initial begin
 
  // Make operands randomize values
  always begin
    #2 clk = ~clk;
  end
 
  // This is the Design Under Test (DUT)
  Multiplier mul (.*);
endmodule // test
