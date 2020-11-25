`timescale 1ns/10ps
 
module d_ext_test;
  // inputs to the DUT are of type reg
  reg        clk    = 1'b0;
  reg        rst    = 1'b0;
  reg [2:0]  divsel = 3'b001;
  reg [31:0] a      = -32'd11;
  reg [31:0] b      = 32'd2;
 
  // outputs from the DUT are of type wire
  wire        ready;
  wire [31:0] res;
  
  initial begin
    $display($time, " << Starting the Simulation >> ");
    #100 divsel = 3'b010;
    #100 divsel = 3'b011;
    #100 divsel = 3'b100;
    #100 divsel = 3'b001;
  end // initial begin
  
  initial begin
    #400 a = 32'd4;
  end // initial begin
  
  initial begin
    #400 b = 32'd0;
  end // initial begin
 
  // Make operands randomize values
  always begin
    #1 clk = ~clk;
  end
 
  // This is the Design Under Test (DUT)
  Divider div (.*);
endmodule // test
