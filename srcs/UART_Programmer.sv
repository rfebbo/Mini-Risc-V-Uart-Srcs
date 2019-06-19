`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Garrett S. Rose. Grayson Bruner
//   University of Tennessee, Knoxville
// 
// Created:
//   May 20, 2019
// 
// Module name: UART_Programmer
// Description:
//   Implements functionality for receiving and programming new instruction codes
//   over UART. 
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   rx -- uart recv pin
//   rst -- reset
// Output:
//   state_load_prog -- high when memory controller is in its reprogramming state
//   douta -- output from instruction memory. Instruction at requested address, or 
//       last programmed address when reprogramming
// 
//////////////////////////////////////////////////////////////////////////////////

module UART_Programmer (
    main_bus bus
);

//baud rate of 115200 with 100 MHz clk makes baud count of 880-something / 16 = 54 (or 53 w/ 0)
integer baud_count = 53;
//integer baud_count = 26;
integer cnt;

logic[7:0] rx_data; //incoming byte

//vars for uart
logic en_16_x_baud;
logic read_from_uart_rx, uart_rx_data_present, uart_rx_half_full, uart_rx_full;

//vars for memory controller
logic memcon_prog_ena, memcon_ena;
logic[31:0] memcon_douta;
logic state_load_prog_buf;

//vars for fifo
logic fifo_wea, fifo_rea;
logic[31:0] fifo_dout;
logic fifo_full, fifo_empty;

//write flags
logic rx_to_fifo, fifo_to_memcon;

//module declarations

//I borrowed this from the SIMON lab in EE559. Thanks Dr. Rose!
uart_rx6 urx(.serial_in(bus.rx), .en_16_x_baud(en_16_x_baud), .data_out(rx_data),
	.buffer_read(read_from_uart_rx), 
	.buffer_data_present(uart_rx_data_present),
	.buffer_half_full(uart_rx_half_full), .buffer_full(uart_rx_full),
	.buffer_reset(bus.Rst), .clk(bus.clk));

//I also borrowed this too. Thanks again!
FIFO_8I32O fifo(.CLK(bus.clk), .RST(bus.Rst), .WriteEn(fifo_wea), 
	.DataIn(rx_data), .ReadEn(fifo_rea), 
	.DataOut(fifo_dout), .Empty(fifo_empty), .Full(fifo_full));

assign bus.uart_dout = fifo_dout;
assign bus.memcon_prog_ena = memcon_prog_ena;

always_ff @(posedge bus.clk) begin
	if (bus.Rst) begin
		rx_to_fifo <= 0;
		fifo_to_memcon <= 0;
		fifo_wea <= 0;
		fifo_rea <= 0;
	end
	else begin
		//write from rx to fifo
		if (uart_rx_data_present) begin
			if (!rx_to_fifo) begin
				rx_to_fifo <= 1;
				read_from_uart_rx <= 0;
				fifo_wea <= 0;
			end
			else if (!fifo_full) begin
				rx_to_fifo <= 0;
				read_from_uart_rx <= 1;
				fifo_wea <= 1;
			end
			else begin
				rx_to_fifo <= 0;
				read_from_uart_rx <= 0;
				fifo_wea <= 0;
			end
		end
		else begin
			rx_to_fifo <= 0;
			read_from_uart_rx <= 0;
			fifo_wea <= 0;
		end

		//write from fifo to memcon
		if ((!fifo_empty) || fifo_to_memcon) begin
			if (!fifo_to_memcon) begin
				fifo_to_memcon <= 1;
				fifo_rea <= 0;
				memcon_prog_ena <= 0;
			end
			else if (!fifo_rea) begin
				fifo_to_memcon <= 1;
				fifo_rea <= 1;
				memcon_prog_ena <= 0;
			end
			else begin
				fifo_to_memcon <= 0;
				fifo_rea <= 0;
				memcon_prog_ena <= 1;
			end
		end
		else begin
			fifo_to_memcon <= 0;
			fifo_rea <= 0;
			memcon_prog_ena <= 0;
		end
	end
end

//Baudrate control 
always_ff @(posedge bus.clk) begin
	if (cnt == baud_count) begin
		cnt <= 0;
		en_16_x_baud <= 1'b1;
	end
	else begin
		cnt <= cnt + 1;
		en_16_x_baud <= 1'b0;
	end
end


endmodule //UART_Programmer
