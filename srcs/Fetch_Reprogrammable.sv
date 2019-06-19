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

logic [11:0] pc_incr;
logic [31:0] memdout;
logic [11:0] next_addr;
logic [11:0] pres_addr;
logic [9:0] addr_in;
logic En_sig, En_mem, state_load_prog;
logic [9:0] debug_addr_imm;
//logic [11:0] branoff;

assign debug_addr_imm[9:5] = 5'b00000;
assign debug_addr_imm[4:0] = bus.debug_input;

//assign branoff[11] = bus.branoff[7];
//assign branoff[10:7] = 4'b0000;
//assign branoff[6:0] = bus.branoff[6:0];

assign bus.IF_ID_pres_addr = pres_addr;
assign pc_incr=(bus.branch)?bus.branoff:12'h004;
assign next_addr=bus.IF_ID_jalr?bus.branoff:(pres_addr+pc_incr);
assign En_sig=(bus.PC_En&&(!bus.debug)); 
//assign En_sig=(bus.PC_En&&(!bus.dbg));
assign En_mem=En_sig || bus.prog;
assign bus.ins=bus.Rst?32'h00000000:memdout;
assign addr_in=bus.prog?debug_addr_imm:pres_addr[11:2];

always_ff @(posedge bus.clk) begin
	if (bus.Rst || bus.memcon_prog_ena) pres_addr <= 12'h000;
	else if (En_sig) pres_addr <= next_addr; 
end

//UART_Programmer mem(.clk(bus.clk), .rx(bus.rx), .rst(bus.Rst), .ena(En_mem), .addra(addr_in), .douta(memdout), .*);
Memory_Controller mem(.clk(bus.clk), .rst(bus.Rst), .ena(En_mem), .prog_ena(bus.memcon_prog_ena), .wea_in(4'b0000), 
        .dina(bus.uart_dout), .addr_in(addr_in), .state_load_prog(state_load_prog), .douta(memdout));

endmodule
