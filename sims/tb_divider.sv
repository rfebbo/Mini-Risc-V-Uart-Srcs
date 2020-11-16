`timescale 1ns/10ps
 
module d_ext_test;
  // inputs to the DUT are of type reg
  reg        clk        = 1'b0;
  reg        rst        = 1'b0;
  reg        op_valid   = 1'b1;
  reg [31:0] opcode     = 32'h2004033;
  reg [31:0] op_pc      = 32'h00000000;
  reg        op_invalid = 1'b0;
  reg [4:0]  op_rd      = 4'b0001;
  reg [4:0]  op_ra      = 4'b0010;
  reg [4:0]  op_rb      = 4'b0011;
  reg [31:0] op_ra_operand = 32'h00000009;
  reg [31:0] op_rb_operand = 32'hFFFFFFFD;
 
  // outputs from the DUT are of type wire
  wire        wb_valid;
  wire [31:0] wb_value;

  // debug
  wire        dbg_valid_q;
  wire [31:0] dbg_wb_result_q;
  wire        dbg_inst_div_w;
  wire        dbg_inst_divu_w;
  wire        dbg_inst_rem_w;
  wire        dbg_inst_remu_w;
  wire        dbg_div_rem_inst_w;
  wire        dbg_signed_operation_w;
  wire        dbg_div_operation_w;
  wire [31:0] dbg_dividend_q;
  wire [62:0] dbg_divisor_q;
  wire [31:0] dbg_quotient_q;
  wire [31:0] dbg_q_mask_q;
  wire        dbg_div_inst_q;
  wire        dbg_div_busy_q;
  wire        dbg_invert_res_q;
  wire        dbg_div_start_w;
  wire        dbg_div_complete_w;
  wire [31:0] dbg_div_result_r;
  
  initial begin
    $display($time, " << Starting the Simulation >> ");
    #1000 opcode = 32'h2005033;
    #1000 opcode = 32'h2006033;
    #1000 opcode = 32'h2007033;
  end // initial begin
  
  initial begin
    #100 op_valid = 1'b0;
    #900 op_valid = 1'b1;
    #100 op_valid = 1'b0;
    #900 op_valid = 1'b1;
    #100 op_valid = 1'b0;
    #900 op_valid = 1'b1;
    #100 op_valid = 1'b0;
    #900 op_valid = 1'b1;
  end // initial begin
  
  initial begin
    #1000 op_rb_operand = 32'h00000004;
    #1000 op_rb_operand = 32'h00000007;
    #1000 op_rb_operand = 32'h00000006;
  end // initial begin
  
  initial begin
    #1000 op_ra_operand = 32'h00000002;
    #1000 op_ra_operand = 32'hFFFFFFFA;
    #1000 op_ra_operand = 32'h00000005;
  end // initial begin
 
  // Make operands randomize values
  always begin
    #2 clk = ~clk;
  end
 
  // This is the Design Under Test (DUT)
  riscv_divider div
  (
    .clk_i(clk),
    .rst_i(rst),
    .opcode_valid_i(op_valid),
    .opcode_opcode_i(opcode),
    .opcode_pc_i(op_pc),
    .opcode_invalid_i(op_invalid),
    .opcode_rd_idx_i(op_rd),
    .opcode_ra_idx_i(op_ra),
    .opcode_rb_idx_i(op_rb),
    .opcode_ra_operand_i(op_ra_operand),
    .opcode_rb_operand_i(op_rb_operand),
    .writeback_valid_o(wb_valid),
    .writeback_value_o(wb_value),
    .debug_valid_q(dbg_valid_q),
    .debug_wb_result_q(dbg_wb_result_q),
    .debug_inst_div_w(dbg_inst_div_w),
    .debug_inst_divu_w(dbg_inst_divu_w),
    .debug_inst_rem_w(dbg_inst_rem_w),
    .debug_inst_remu_w(dbg_inst_remu_w),
    .debug_div_rem_inst_w(dbg_div_rem_inst_w),
    .debug_signed_operation_w(dbg_signed_operation_w),
    .debug_div_operation_w(dbg_div_operation_w),
    .debug_dividend_q(dbg_dividend_q),
    .debug_divisor_q(dbg_divisor_q),
    .debug_quotient_q(dbg_quotient_q),
    .debug_q_mask_q(dbg_q_mask_q),
    .debug_div_inst_q(dbg_div_inst_q),
    .debug_div_busy_q(dbg_div_busy_q),
    .debug_invert_res_q(dbg_invert_res_q),
    .debug_div_start_w(dbg_div_start_w),
    .debug_div_complete_w(dbg_div_complete_w),
    .debug_div_result_r(dbg_div_result_r)
  );
endmodule // test
