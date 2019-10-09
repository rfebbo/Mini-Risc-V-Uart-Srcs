`timescale 1ns / 1ps

interface riscv_bus (
    input logic clk, Rst, debug, rx, prog, 
    input logic [4:0] debug_input
//    output logic [31:0] debug_output
    
    );

    logic mem_wea;
    logic [3:0] mem_en; 
    logic [31:0] mem_addr;
    logic [31:0] mem_din, mem_dout; 
    logic [31:0] debug_output;
    
    logic imem_en, imem_prog_ena;
    logic [9:0] imem_addr;
    logic [31:0] imem_dout, imem_din; 
    
    modport core(
        input clk, Rst, debug, rx, prog, debug_input, mem_dout, imem_dout,
        output debug_output, mem_wea, mem_en, mem_addr, mem_din, imem_en, 
        output imem_addr, imem_din, imem_prog_ena
    );
    
    modport memcon(
        input clk, Rst, mem_wea, mem_en, mem_addr, mem_din, imem_en, 
        input imem_addr, imem_din, imem_prog_ena,
        output mem_dout, imem_dout
    );
endinterface

interface mmio_bus (
        input logic clk, Rst, 
        input logic [4:0] debug_input
    );
    
    logic disp_wea;
    logic [31:0] disp_dat; 
    logic [31:0] disp_out;
    
    modport memcon(
        input clk, Rst,
        output disp_dat, disp_wea
    );
    
    modport display(
        input clk, Rst, disp_wea, disp_dat, debug_input, 
        output disp_out
    );
    
endinterface

module rv_top
 (input  logic       clk,
  input  logic       Rst,
  input  logic       debug,
  input  logic       rx, //uart recv pin
  input  logic       prog, //similar to debug, but shows mem addr, and allows reprogramming
//  input  logic       addr_dn,
//  input  logic       addr_up,
  input  logic [4:0] debug_input,
  output logic tx, clk_out,
  output logic [6:0] sev_out,
  output logic [7:0] an,
  output logic [15:0] led);

  logic [31:0] debug_output;
  logic [3:0]  seg_cur, seg_nxt;
  logic        clk_50M, clk_disp;
  logic addr_dn, addr_up;
  //clock divider variable
  integer      count;
  
  logic rst_in, rst_last;
  
//  logic mem_wea;
//  logic [3:0] mem_en;
//  logic [11:0] mem_addr;
//  logic [31:0] mem_din, mem_dout;
  riscv_bus rbus(.*);
  mmio_bus mbus(.*);
//  riscv_bus rbus(.clk(clk_50M), .*);
//  mmio_bus mbus(.clk(clk_50M), .*);
  
  assign debug_output = (prog | debug ) ? rbus.debug_output : mbus.disp_out;
  

  enum logic [7:0] {a0=8'b11111110, a1=8'b11111101,
                    a2=8'b11111011, a3=8'b11110111,
                    a4=8'b11101111, a5=8'b11011111,
                    a6=8'b10111111, a7=8'b01111111} 
                    an_cur, an_nxt;

  //RISCVcore rv_core(.clk(clk), .*);
//  RISCVcore_uart rv_core(.*);
//    RISCVcore_uart rv_core(.clk(clk_50M), .*);  
    RISCVcore_uart rv_core(rbus.core);    
    Memory_Controller memcon0(rbus.memcon, mbus.memcon);
    
    Debug_Display d0(mbus.display);
    
//    Memory_byteaddress mem0(.clk(clk_50M), .rst(Rst), .wea(mem_wea), .en(mem_en), .addr(mem_addr),
//        .din(mem_din), .dout(mem_dout));
    
  //clock divider logic
  always @(posedge clk) begin
    rst_last <= Rst;
    if (Rst == 1'b1 && rst_in == 1'b0 && rst_last == 1'b0) 
        rst_in <= 1;
    else
        rst_in <= 0;
     count <= count + 1;
     clk_50M<=!clk_50M;
     if(count==500)
     begin
        count<=0;
        clk_disp <= !clk_disp;
     end
  end
 
  //clk_wiz_0 clk_div0(clk_50M, clk);
  //clk_wiz_1 clk_div1(clk_5M, clk_50M);

  assign an = an_cur;
  assign led = debug_output[15:0];
  assign clk_out = clk_50M;
  
  always_ff @(posedge clk_disp) begin
    if (Rst) begin
      an_cur <= a0;
      seg_cur <= debug_output[3:0];
    end
    else begin
      an_cur <= an_nxt;
      seg_cur <= seg_nxt;
    end
  end

  always_comb begin
    case(an_cur)
      a0: begin 
            an_nxt = a1;
            seg_nxt = debug_output[7:4];
          end
      a1: begin 
            an_nxt = a2;
            seg_nxt = debug_output[11:8];
          end
      a2: begin 
            an_nxt = a3;
            seg_nxt = debug_output[15:12];
          end
      a3: begin 
            an_nxt = a4;
            seg_nxt = debug_output[19:16];
          end
      a4: begin 
            an_nxt = a5;
            seg_nxt = debug_output[23:20];
          end
      a5: begin 
            an_nxt = a6;
            seg_nxt = debug_output[27:24];
          end
      a6: begin 
            an_nxt = a7;
            seg_nxt = debug_output[31:28];
          end
      a7: begin 
            an_nxt = a0;
            seg_nxt = debug_output[3:0];
          end
      default: begin 
            an_nxt = a0;
            seg_nxt = debug_output[3:0];
          end
    endcase
  end

  always_comb begin
    case (seg_cur)
      4'b0000: sev_out = 7'b0000001;
      4'b0001: sev_out = 7'b1001111; 
      4'b0010: sev_out = 7'b0010010; 
      4'b0011: sev_out = 7'b0000110; 
      4'b0100: sev_out = 7'b1001100; 
      4'b0101: sev_out = 7'b0100100; 
      4'b0110: sev_out = 7'b0100000; 
      4'b0111: sev_out = 7'b0001111; 
      4'b1000: sev_out = 7'b0000000; 
      4'b1001: sev_out = 7'b0000100; 
      4'b1010: sev_out = 7'b0001000;
      4'b1011: sev_out = 7'b1100000;
      4'b1100: sev_out = 7'b0110001;
      4'b1101: sev_out = 7'b1000010;
      4'b1110: sev_out = 7'b0110000;
      4'b1111: sev_out = 7'b0111000;
      default: sev_out = 7'b0000000;
    endcase
  end
  
//  integer cnt = 0;
//    integer maxcnt = 100000000;
//    always_ff @(posedge clk) begin
//        if (Rst) begin
//            cnt = 0;
//        end else if (~(debug || prog)) begin
//            if (cnt == maxcnt) begin
//                cnt <= 0;
//                addr_dn <= 1;
//            end else begin
//                cnt <= cnt + 1;
//                addr_dn <= 0;
//            end
//        end
//    end
endmodule: rv_top
			  
