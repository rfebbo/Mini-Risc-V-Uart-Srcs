`timescale 1ns / 1ps


module uart_controller
(
  mmio_bus mbus
);
    
  logic       clk, rst, rx, rx_ren, tx_wen;
  logic [7:0] din;
  logic       tx;
  logic [7:0] dout;

  always_comb begin
    clk                  = mbus.clk;
    rst                  = mbus.Rst; 
    rx                   = mbus.rx;
    rx_ren               = mbus.rx_ren; 
    tx_wen               = mbus.tx_wen; 
    din                  = mbus.uart_din;
    mbus.tx              = tx;
    mbus.rx_data_present = ~rx_fifo_empty;
    mbus.tx_full         = tx_fifo_full;
    mbus.uart_dout       = dout;
  end

  integer cnt        = 27;
  integer baud_count = 0; 
  logic   en_baud    = 0;
    
  logic [7:0] rx_dout; 
  logic       rx_read, rx_pres, rx_half, rx_full; 
    
  logic [7:0] tx_din;
  logic       tx_write, tx_pres, tx_half, tx_full; 
    
  logic       rx_fifo_wen, rx_fifo_ren; 
  logic       rx_fifo_full, rx_fifo_empty; 
  logic [7:0] rx_fifo_dout; 
  logic [9:0] rx_fifo_count; 
    
  logic       tx_fifo_wen, tx_fifo_ren; 
  logic       tx_fifo_full, tx_fifo_empty; 
  logic [7:0] tx_fifo_din; 

  assign rx_read = rx_pres & ~rx_fifo_full;

  assign rx_fifo_ren = rx_ren;
  assign dout        = rx_fifo_dout;

  uart_rx6 rx0
  (
    .serial_in(rx),
    .en_16_x_baud(en_baud),
    .data_out(rx_dout),
    .buffer_read(rx_read),
    .buffer_data_present(rx_pres),
    .buffer_half_full(rx_half),
    .buffer_full(rx_full),
    .buffer_reset(rst),
    .clk(clk)
  ); 
        
  fifo_generator_0 rxfifo
  (
    .clk(clk),
    .rst(rst),
    .din(rx_dout),
    .wr_en(rx_read),
    .rd_en(rx_fifo_ren),
    .dout(rx_fifo_dout),
    .full(rx_fifo_full),
    .empty(rx_fifo_empty)
  ); 

  assign tx_fifo_wen = tx_wen;
  assign tx_fifo_ren = ~tx_fifo_empty & ~tx_full; 
    
  assign tx_fifo_din = din;

  uart_tx6 tx0
  (
    .data_in(tx_din),
    .en_16_x_baud(en_baud),
    .serial_out(tx),
    .buffer_write(tx_write),
    .buffer_data_present(tx_pres),
    .buffer_half_full(tx_half),
    .buffer_full(tx_full),
    .buffer_reset(rst),
    .clk(clk)
  );
    
  fifo_generator_0 txfifo
  (
    .clk(clk),
    .rst(rst),
    .din(tx_fifo_din),
    .wr_en(tx_fifo_wen),
    .rd_en(tx_fifo_ren),
    .dout(tx_din),
    .full(tx_fifo_full),
    .empty(tx_fifo_empty)
  );
    
  always_ff @(posedge clk) begin
    tx_write    <= tx_fifo_ren;
    rx_fifo_wen <= rx_read;

    if (baud_count == cnt) begin
      baud_count <= 0;
      en_baud    <= 1;
    end
    else begin
      baud_count <= baud_count + 1; 
      en_baud    <= 0;
    end
  end
endmodule
