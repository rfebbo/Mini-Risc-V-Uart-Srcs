`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: RISCVcore
// Description:
//   Implements top Mini-RISC-V core logic
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   Rst -- system reset signal
//   debug -- 1-bit debug control signal
//   debug_input -- 5-bit register address for viewing via debug port
// Output:
//   debug_output -- 32-bit output port for viewing contents of register
// 
//////////////////////////////////////////////////////////////////////////////////

//Interface bus between all pipeline stages
interface main_bus (
    input logic clk, Rst, debug, rx, prog,
    input logic[4:0] debug_input);
    
    logic         PC_En;
    logic         hz;
    logic         branch;
    logic  [11:0]  branoff;
    logic  [11:0]  ID_EX_pres_addr;
    logic  [31:0] ins;
    logic  [4:0]  ID_EX_rd;
    logic         ID_EX_memread,ID_EX_regwrite;
    logic  [4:0]  EX_MEM_rd,MEM_WB_rd,WB_ID_rd;
    logic  [4:0]  ID_EX_rs1,ID_EX_rs2;
    logic  [31:0] ID_EX_dout_rs1,ID_EX_dout_rs2,EX_MEM_dout_rs2;
    logic  [31:0] IF_ID_dout_rs1,IF_ID_dout_rs2;
    logic  [11:0]  IF_ID_pres_addr;
    logic         IF_ID_jalr;
    logic         ID_EX_jal,ID_EX_jalr;
    logic         ID_EX_compare;
    logic  [31:0] EX_MEM_alures,MEM_WB_alures,MEM_WB_memres;
    logic         EX_MEM_comp_res;
    
    logic  [4:0]  EX_MEM_rs2;
    
    logic  [2:0]  ID_EX_alusel;
    logic  [4:0]  ID_EX_loadcntrl;
    logic  [2:0]  ID_EX_storecntrl;
    logic  [3:0]  ID_EX_cmpcntrl;
    logic  [4:0]  EX_MEM_loadcntrl;
    logic  [2:0]  EX_MEM_storecntrl;
    logic         ID_EX_alusrc;
    logic         EX_MEM_memread,MEM_WB_memread;
    logic         ID_EX_memwrite,EX_MEM_memwrite;
    logic         EX_MEM_regwrite,MEM_WB_regwrite,WB_ID_regwrite;
    logic         ID_EX_lui;
    logic         ID_EX_auipc;
    logic  [31:0] ID_EX_imm;
    logic  [31:0] WB_res,WB_ID_res;
    logic  [4:0]  adr_rs1;//used for debug option
    logic  [4:0]  IF_ID_rs1,IF_ID_rs2;
    logic         ID_EX_lb,ID_EX_lh,ID_EX_lw,ID_EX_lbu,ID_EX_lhu,ID_EX_sb,ID_EX_sh,ID_EX_sw;
    logic         EX_MEM_lb,EX_MEM_lh,EX_MEM_lw,EX_MEM_lbu,EX_MEM_lhu,EX_MEM_sb,EX_MEM_sh,EX_MEM_sw;
    logic dbg;
    logic [31:0] uart_dout;
    logic memcon_prog_ena;
    
    logic mmio_wea;
    logic [31:0] mmio_dat;
    
    //modport declarations. These ensure each pipeline stage only sees and has access to the 
    //ports and signals that it needs
    
    //modport for fetch stage
    modport fetch(
        input clk, PC_En, debug, prog, Rst, branch, IF_ID_jalr, 
        input dbg,
        //input rx,
        input uart_dout, memcon_prog_ena,
        input debug_input, branoff,
        output IF_ID_pres_addr, ins
    );
    
    //modport for register file
    modport regfile(
        input clk, adr_rs1, IF_ID_rs2, MEM_WB_rd,
        input WB_res, MEM_WB_regwrite,
        output IF_ID_dout_rs1, IF_ID_dout_rs2 
    ); 
        
    //modport for decode stage
    modport decode(
        input clk, Rst, dbg, ins, IF_ID_pres_addr, MEM_WB_rd, WB_res,
        input EX_MEM_memread, EX_MEM_regwrite, MEM_WB_regwrite, EX_MEM_alures,
        input EX_MEM_rd, IF_ID_dout_rs1, IF_ID_dout_rs2, 
        inout ID_EX_memread, ID_EX_regwrite,
        output ID_EX_pres_addr, IF_ID_jalr, ID_EX_jalr, branch,
        output IF_ID_rs1, IF_ID_rs2,
        output ID_EX_dout_rs1, ID_EX_dout_rs2, branoff, hz,
        output ID_EX_rs1, ID_EX_rs2, ID_EX_rd, ID_EX_alusel,
        output ID_EX_storecntrl, ID_EX_loadcntrl, ID_EX_cmpcntrl,
        output ID_EX_auipc, ID_EX_lui, ID_EX_alusrc, 
        output ID_EX_memwrite, ID_EX_imm, ID_EX_compare, ID_EX_jal
    );
     
    //modport for execute stage    
    modport execute(
        input clk, Rst, dbg, ID_EX_lui, ID_EX_auipc, ID_EX_loadcntrl,
        input ID_EX_storecntrl, ID_EX_cmpcntrl, 
        output EX_MEM_loadcntrl, EX_MEM_storecntrl, 
        input ID_EX_compare, ID_EX_pres_addr, ID_EX_alusel, ID_EX_alusrc,
        input ID_EX_memread, ID_EX_memwrite, ID_EX_regwrite, ID_EX_jal,
        input ID_EX_jalr, ID_EX_rs1, ID_EX_rs2, ID_EX_rd, ID_EX_dout_rs1, ID_EX_dout_rs2,
        output EX_MEM_dout_rs2, EX_MEM_rs2,
        input ID_EX_imm, MEM_WB_regwrite, WB_ID_regwrite,
        output EX_MEM_alures,
        input WB_res, WB_ID_res, 
        output EX_MEM_memread, EX_MEM_rd,
        input MEM_WB_rd, WB_ID_rd,
        output EX_MEM_memwrite, EX_MEM_regwrite, EX_MEM_comp_res
    );
    
    //modport for memory stage
    modport memory (
        input clk, Rst, dbg, EX_MEM_storecntrl,
        input EX_MEM_loadcntrl, EX_MEM_alures, EX_MEM_dout_rs2, EX_MEM_rs2, WB_res,
        input EX_MEM_rd, EX_MEM_regwrite, EX_MEM_memread, EX_MEM_memwrite,
        output MEM_WB_regwrite, MEM_WB_memread, MEM_WB_rd, MEM_WB_alures, MEM_WB_memres,
        output mmio_wea, mmio_dat
    );
    
    //modport for writeback stage
    modport writeback(
        input clk, Rst, dbg, MEM_WB_alures, MEM_WB_memres, MEM_WB_memread, 
        input MEM_WB_regwrite, MEM_WB_rd,
        output WB_ID_regwrite, WB_ID_rd, WB_res, WB_ID_res
    );
    
    //modport for UART programmer
    modport UART_Programmer(
        input clk, Rst, rx,
        output uart_dout, memcon_prog_ena
    );
   
    
endinterface

module RISCVcore_uart(    input   logic         clk,
    input   logic         Rst,
    input   logic         debug,
    input   logic         rx, //uart recv
    input   logic         prog, //reprogram or view instruction memory
    input   logic [4:0]   debug_input,
    output  logic [31:0]  debug_output

    );

    main_bus bus(.*);
    

    assign bus.PC_En=!bus.hz;
    assign bus.dbg=(debug || prog); //added to stop pipeline on prog and/or debug
    //debugging resister
    assign bus.adr_rs1=debug ? debug_input:bus.IF_ID_rs1;
    
    always_ff @(posedge clk) begin
        if(Rst) begin
            debug_output<=32'h00000000;
        end
        else if (prog) begin //debug instruction memory
            debug_output<=bus.ins;
        end
        else if(debug) begin //debug register
            debug_output<=bus.IF_ID_dout_rs1;
        end
        else begin
            debug_output<=bus.mmio_dat;
        end
    end

    Fetch_Reprogrammable u1(bus.fetch);
    
    //register file
    Regfile u0(bus.regfile);
    
    Decode u2(bus.decode);
    
    Execute u3(bus.execute);
    
    Memory u4(bus.memory);
    
    Writeback u5(bus.writeback);
    
    UART_Programmer uart(bus.UART_Programmer);
    
endmodule
