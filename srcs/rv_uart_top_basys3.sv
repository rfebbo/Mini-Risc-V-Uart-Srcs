`timescale 1ns / 1ps


interface riscv_bus
  (
    input logic        clk, Rst, debug, prog,
    input logic [4:0]  debug_input,
    input logic [95:0] key
  );

  logic        mem_wea, mem_rea;
  logic [3:0]  mem_en; 
  logic [31:0] mem_addr;
  logic [31:0] mem_din, mem_dout; 
  logic [31:0] debug_output;
    
  logic        imem_en, imem_prog_ena;
  logic [31:0] imem_addr;
  logic [31:0] imem_dout, imem_din; 
    
  logic mem_hold;
    
  modport core
  (
    input  clk, Rst, debug, prog, debug_input, mem_dout, imem_dout,
    output debug_output, mem_wea, mem_rea, mem_en, mem_addr, mem_din, imem_en, 
    output imem_addr, imem_din, imem_prog_ena,
    input  key, input mem_hold
  );
    
  modport memcon
  (
    input  clk, Rst, mem_wea, mem_en, mem_addr, mem_din, imem_en, 
    input  imem_addr, imem_din, imem_prog_ena, mem_rea,
    output mem_dout, imem_dout, mem_hold
  );
endinterface


interface mmio_bus
  (
    input  logic       clk, Rst, rx,
    input  logic [4:0] debug_input,
    output logic       tx
  );

  logic [31:0] led;
  logic        disp_wea;
  logic [31:0] disp_dat; 
  logic [31:0] disp_out;

  // UART ports.
  logic [7:0] uart_din, uart_dout; 
  logic       rx_ren, tx_wen, rx_data_present;
  logic       tx_full;

  modport memcon
  (
    input  clk, Rst,
    output disp_dat, disp_wea, led, 

    input  uart_dout, rx_data_present, tx_full,
    output uart_din, rx_ren, tx_wen
  );

  modport display
  (
    input  clk, Rst, disp_wea, disp_dat, debug_input, 
    output disp_out
  );
    
  modport uart
  (
    input  clk, Rst, rx, rx_ren, tx_wen, uart_din,
    output rx_data_present, tx, uart_dout, tx_full
  );
endinterface


module rv_uart_top
  (
    input  logic        clk,
    input  logic        Rst,
    input  logic        debug,
    input  logic        rx,   // UART receive pin.
    input  logic        prog, // Similar to debug, but shows memory address, and allows reprogramming.
    input  logic [4:0]  debug_input,
    output logic        tx, clk_out,
    output logic [6:0]  sev_out,
    output logic [3:0]  an,
    output logic [15:0] led
  );

  logic [31:0] debug_output;
  logic [3:0]  seg_cur, seg_nxt;
  logic        clk_50M, clk_5M,clk_7seg;
  logic        addr_dn, addr_up;
  logic [95:0] key; 

  assign key[95:48] = 48'h3cf3cf3cf3cf;
  assign key[47:24] = 24'h30c30c;
  assign key[23:12] = 12'hbae;
  assign key[11:0]  = 12'h3cf;

  logic rst_in, rst_last;

  clk_wiz_0 c0(.*);
  riscv_bus rbus(.clk(clk_50M), .*);
  mmio_bus  mbus(.clk(clk_50M),  .*);
  clk_div   cdiv(clk,Rst,16'd500,clk_7seg);

  assign led = {14'h0, mbus.tx_full, mbus.rx_data_present};

  assign debug_output = (prog | debug ) ? rbus.debug_output : mbus.disp_out;

  enum logic [7:0] {a0=8'b11111110, a1=8'b11111101,
                    a2=8'b11111011, a3=8'b11110111,
                    a4=8'b11101111, a5=8'b11011111,
                    a6=8'b10111111, a7=8'b01111111} 
                    an_cur, an_nxt;

  RISCVcore_uart    rv_core(rbus.core);
  Memory_Controller memcon0(rbus.memcon, mbus.memcon);
    
  Debug_Display   d0(mbus.display);
  uart_controller u0(mbus.uart);

  assign an      = an_cur[3:0];
  assign clk_out = clk_50M;
  
  always_ff @(posedge clk_7seg) begin
    if (Rst) begin
      an_cur  <= a0;
      seg_cur <= debug_output[3:0];
    end
    else begin
      an_cur  <= an_nxt;
      seg_cur <= seg_nxt;
    end
  end

  always_comb begin
    case(an_cur)
      a0: begin 
        an_nxt  = a1;
        seg_nxt = debug_output[7:4];
      end
      a1: begin 
        an_nxt  = a2;
        seg_nxt = debug_output[11:8];
      end
      a2: begin 
        an_nxt  = a3;
        seg_nxt = debug_output[15:12];
      end
      a3: begin 
        an_nxt  = a4;
        seg_nxt = debug_output[19:16];
      end
      a4: begin 
        an_nxt  = a5;
        seg_nxt = debug_output[23:20];
      end
      a5: begin 
        an_nxt  = a6;
        seg_nxt = debug_output[27:24];
      end
      a6: begin 
        an_nxt  = a7;
        seg_nxt = debug_output[31:28];
      end
      a7: begin 
        an_nxt  = a0;
        seg_nxt = debug_output[3:0];
      end
      default: begin 
        an_nxt  = a0;
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
endmodule: rv_uart_top
