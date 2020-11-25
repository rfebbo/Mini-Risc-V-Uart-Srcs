`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose. Grayson Bruner
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// Modified:
//   May 20, 2019
// 
// Module name: Fetch_Reprogrammable
// Description:
//   Implements the RISC-V fetch pipeline stage. This functions almost identically
//   to the original fetch module, however this one has added functionality
//   to reprogram the instruction memory through UART.
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   En -- enable signal
//   debug -- debug I/O control
//   prog -- debug or reprogram instruction memory
//   Rst -- system reset
//   branch -- branch single
//   IF_ID_jalr -- flag jump and link for subrouting return
//   rx -- uart recv pin
//   branoff -- 16-bit offset for branching
// Output:
//   IF_ID_pres_adr -- 16-bit program counter address
//   ins -- 32-bit instruction operation code
// 
//////////////////////////////////////////////////////////////////////////////////

//This functions almost identically to the original fetch module, however this one has added functionality
//to reprogram the instruction memory through UART.
module Fetch_Reprogrammable(main_bus bus);

logic [31:0] pc_incr;
logic [31:0] memdout;
logic [31:0] next_addr;
logic [31:0] pres_addr;
logic [31:0] addr_in;
logic En_sig, En_mem, state_load_prog;
logic [31:0] debug_addr_imm;
//logic [11:0] branoff;
logic LAA_ins_sig;
assign debug_addr_imm[9:5] = 5'b00000;
assign debug_addr_imm[4:0] = bus.debug_input;

  assign memdout = bus.imem_dout;

assign pc_incr=bus.branch?bus.branoff:12'h004;
//assign next_addr=bus.IF_ID_jalr?bus.branoff: bus.IF_ID_jal ? (bus.IF_ID_pres_addr + pc_incr) : (pres_addr+pc_incr);
assign next_addr=bus.trap ? bus.mtvec : bus.IF_ID_jalr?bus.branoff: bus.IF_ID_jal ? (bus.IF_ID_pres_addr + pc_incr)
     : bus.branch ? (bus.IF_ID_pres_addr+pc_incr) : (pres_addr+pc_incr);
assign En_sig=(bus.PC_En&&(!bus.debug)&&(!bus.dbg)&&(!bus.mem_hold))  && !(LAA_ins_sig && (bus.LAA_busy)); 
assign LAA_ins_sig = (|bus.LAA_ins);
	//assign En_sig=(bus.PC_En&&(!bus.dbg));
assign En_mem=En_sig || bus.prog;
assign bus.ins = bus.Rst ? 32'h00000000 : (memdout[6:0] != 7'b0001011) ? memdout : 'd0;
assign bus.LAA_ins = bus.Rst ? 32'h00000000 : (memdout[6:0] == 7'b0001011) ? memdout : 'd0;

//assign bus.ins=bus.Rst?32'h00000000:En_sig?memdout:32'h00000013;
//assign addr_in=bus.prog?debug_addr_imm:pres_addr[11:2];
assign addr_in=bus.prog?debug_addr_imm:pres_addr;
assign bus.imem_en = En_mem; 

  assign next_addr = bus.trap       ? bus.mtvec :
                     bus.IF_ID_jalr ? bus.branoff :
                     bus.IF_ID_jal  ? (bus.IF_ID_pres_addr + pc_incr) :
                     bus.branch     ? (bus.IF_ID_pres_addr + pc_incr) : (pres_addr + pc_incr);

  assign En_sig	= (bus.PC_En && (!bus.debug) && (!bus.dbg) && (!bus.mem_hold));
  assign En_mem	= En_sig || bus.prog;

  assign bus.ins = bus.Rst  ? 32'h00000000 : memdout;
  assign addr_in = bus.prog ? debug_addr_imm : pres_addr;

  assign bus.imem_en   = En_mem; 
  assign bus.imem_addr = addr_in; 

  always_ff @(posedge bus.clk)
  begin
    if (bus.Rst || bus.memcon_prog_ena)
    begin
      pres_addr <= 32'h000;
    end
    else if (En_sig)
    begin
      bus.IF_ID_pres_addr <= pres_addr; 
      pres_addr           <= next_addr;
    end 
    else
    begin
    end
  end
endmodule
