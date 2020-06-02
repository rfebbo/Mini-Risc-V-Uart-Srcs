`timescale 1ns / 1ps


// Interface for RISCV bus.
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


// Interface for MMIO bus.
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
    input  logic        clk,         // Clock
    input  logic        Rst,         // Reset
    input  logic        debug,       // Enables RISCV bus output to be displayed on 7-segment display
    input  logic        rx,          // UART receive pin
    input  logic        prog,        // Similar to debug, but shows memory address, and allows reprogramming
    input  logic [4:0]  debug_input, // Tied to RISCV bus core and MMIO bus display input
    output logic        tx, clk_out, // UART and clock output
    output logic [6:0]  sev_out,     // 7-segment display cathode output
    output logic [3:0]  an,          // 7-segment display anode output
    output logic [15:0] led          // LED output
  );

  logic [31:0] debug_output;             // Program output
  logic [3:0]  seg_cur, seg_nxt;         // 7-segment cathode values
  logic        clk_50M, clk_5M,clk_7seg; // Clocks
  logic        addr_dn, addr_up;         // [UNUSED]
  logic [95:0] key;                      // Key inputted to RISCV bus core

  assign key[95:48] = 48'h3cf3cf3cf3cf; // 0b0011_1100_1111_0011_1100_1111_0011_1100_1111_0011_1100_1111
  assign key[47:24] = 24'h30c30c;       // 0b0011_0000_1100_0011_0000_1100
  assign key[23:12] = 12'hbae;          // 0b1011_1010_1110
  assign key[11:0]  = 12'h3cf;          // 0b0011_1100_1111

  logic rst_in, rst_last; // [UNUSED]

  clk_wiz_0 c0(.*);                            // Clock wizard module instantiation
  riscv_bus rbus(.clk(clk_50M), .*);           // RISCV bus interface instantiation
  mmio_bus  mbus(.clk(clk_50M), .*);           // MMIO bus interface instantiation
  clk_div   cdiv(clk, Rst, 16'd500, clk_7seg); // Clock divider module instantiation

  // 2 LEDs are lit up depending on if MMIO bus tx is full or rx has data present.
  assign led = {14'h0, mbus.tx_full, mbus.rx_data_present}; // LED output on board from MMIO bus memory controller

  // 7-segment display output is RISCV bus output if either prog or debug are enabled
  //                          or MMIO bus output if both are disabled.
  assign debug_output = (prog | debug) ? rbus.debug_output : mbus.disp_out;

  // 1 anode for each digit on 7-segment display.
  enum logic [7:0] {a0=8'b11111110, a1=8'b11111101,
                    a2=8'b11111011, a3=8'b11110111,
                    a4=8'b11101111, a5=8'b11011111,
                    a6=8'b10111111, a7=8'b01111111} 
                    an_cur, an_nxt; // 7-segment anode values

  RISCVcore_uart    rv_core(rbus.core);                // RISCV bus core module instantiation.
  Memory_Controller memcon0(rbus.memcon, mbus.memcon); // RISCV and MMIO bus memory controller module instantiation.

  Debug_Display   d0(mbus.display); // MMIO bus display module instantiation.
  uart_controller u0(mbus.uart);    // MMIO bus UART module instantiation.

  // Outputs current anode and clock.
  assign an      = an_cur[3:0];
  assign clk_out = clk_50M;
  
  // Updates current anode and what it displays, along with resetting the anode.
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

  // Anode activating signals for 4 LEDs - decoder to generate anode signals.
  // Outputs debug output from MMIO bus onto 7-segment display.
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

  // Cathode patterns of the 7-segment LED display.
  // Converts the number to be displayed into corresponding cathode values.
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
