`timescale 1ns / 1ps 


module Memory_Controller
(
  riscv_bus rbus, // RISCV bus
  mmio_bus  mbus  // MMIO bus
);

  logic        clk, rst;            // Clock, reset
  logic        mem_wea, mem_rea;    // Memory write, read enable
  logic [3:0]  mem_en, mem_en_last; // Memory enable, enable last
  logic [11:0] mem_addr_lower;      // Memory lower address
  logic [19:0] mem_addr_upper;      // Memory upper address
  logic [31:0] mem_din, mem_dout;   // Memory data in, out

  logic        disp_wea; // Display write enable
  logic [31:0] disp_dat; // Display data

  logic [31:0] imem_addr, imem_dout, imem_din; // Instruction memory address, data out, in
  logic        imem_en, imem_state;            // Instruction memory enable, state


  logic        mmio_region, kernel_region, prog_region; // MMIO, kernel, programmable region
  logic [31:0] blkmem_dout, doutb, blkmem_din;          // Block memory data out a, b, data in
  logic [7:0]  uart_dout;                               // UART data out
  logic        uart_last_cond;                          // UART last conditional
  logic [11:0] uart_last_addr;                          // UART last address

  logic mem_hold; // Hold signal to memory

  always_comb begin
    clk            = rbus.clk;
    rst            = rbus.Rst; 
    mem_wea        = rbus.mem_wea;
    mem_rea        = rbus.mem_rea;
    mem_din        = rbus.mem_din; 
    rbus.mem_dout  = mem_dout; 
    mem_addr_lower = rbus.mem_addr[11:0]; 
    mem_addr_upper = rbus.mem_addr[31:12];
    mem_en         = ((kernel_region | prog_region) & mem_wea) ? rbus.mem_en : 4'b0000;
    imem_en        = rbus.imem_en; 
    imem_addr      = rbus.imem_addr; 
    imem_din       = rbus.imem_din; 
    rbus.imem_dout = imem_dout;
    rbus.mem_hold  = mem_hold;
  end

  always_comb begin : mem_region
    mmio_region   = (mem_addr_upper == 20'haaaaa); 
    kernel_region = (rbus.mem_addr[31:16] == 16'h0000);
    prog_region   = (rbus.mem_addr[31:16] == 16'h0001); 
  end

  always_comb begin
    mbus.tx_wen   = (mmio_region & (mem_addr_lower == 12'h400)) ? mem_wea : 1'b0;
    mbus.uart_din = (mmio_region & (mem_addr_lower == 12'h400)) ? mem_din[7:0] : 8'h00;
    mbus.rx_ren   = (mmio_region & (mem_addr_lower == 12'h400)) ? mem_rea : 1'b0;
    mbus.disp_wea = (mmio_region & (mem_addr_lower == 12'h008)) ? mem_wea : 1'b0;
    mbus.disp_dat = (mmio_region & (mem_addr_lower == 12'h008)) ? mem_din : 32'h0;
    mem_dout      = uart_last_cond ? ((uart_last_addr == 12'h404) ? {6'b000000, mbus.tx_full, mbus.rx_data_present} : mbus.uart_dout) : blkmem_dout;
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      mem_hold <= 0;
    end
    else begin
      if (mmio_region && ((mem_addr_lower == 12'h400) || (mem_addr_lower == 12'h404))) begin
        uart_last_cond <= 1;
        uart_last_addr <= mem_addr_lower;
      end
      else begin
        uart_last_cond <= 0; 
      end

      mem_en_last <= mem_en;

      if (mem_hold == 1) begin
        mem_hold <= 0;
      end
    end
  end

  always_comb begin
    case (mem_en_last)
      4'b0001: begin
        blkmem_dout = {24'h0, doutb[7:0]}; 
      end
      4'b0010: begin 
        blkmem_dout = {24'h0, doutb[15:8]};
      end
      4'b0100: begin
        blkmem_dout = {24'h0, doutb[23:16]};
      end
      4'b1000: begin
        blkmem_dout = {24'h0, doutb[31:24]};
      end
      4'b0011: begin 
        blkmem_dout = {16'h0, doutb[15:0]};
      end
      4'b0110: begin 
        blkmem_dout = {16'h0, doutb[23:8]};
      end
      4'b1100: begin
        blkmem_dout = {16'h0, doutb[31:16]}; 
      end
      default: begin
        blkmem_dout = doutb;
      end 
    endcase
  end

  always_comb begin
    case (mem_en) 
      4'b0001: begin
        blkmem_din = {24'h0, mem_din[7:0]};
      end
      4'b0010: begin 
        blkmem_din = {16'h0, mem_din[7:0], 8'h0};  
      end
      4'b0100: begin
        blkmem_din = {8'h0, mem_din[7:0], 16'h0};
      end
      4'b1000: begin
        blkmem_din = {mem_din[7:0], 24'h0};
      end
      4'b0011: begin 
        blkmem_din = {16'h0, mem_din[15:0]}; 
      end
      4'b0110: begin 
        blkmem_din = {8'h0, mem_din[15:0], 8'h0};
      end
      4'b1100: begin
        blkmem_din = {mem_din[15:0], 16'h0};
      end
      default: begin
        blkmem_din = mem_din;
      end 
    endcase
  end

  blk_mem_gen_0 sharedmem
  (
    .clka(clk),
    .ena(imem_en),
    .wea(4'b0000),
    .addra(imem_addr),
    .dina(32'hz),
    .douta(imem_dout),
    .clkb(clk),
    .enb((mem_wea | mem_rea) & (kernel_region | prog_region)),
    .web(mem_en),
    .addrb(rbus.mem_addr),
    .dinb(blkmem_din),
    .doutb(doutb)
  );
endmodule : Memory_Controller
