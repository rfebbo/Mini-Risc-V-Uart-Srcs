`timescale 1ns / 1ps 

module Timer #(
	parameter clk_rate = 100000000) (
	input logic clk, rst, start, stop,
	output logic [17:0] dout, 
	);

	logic [15:0] cnt = 32'h00000000;

	logic ena = 0;
	logic ovflw = 0;

	assign dout = {ena, ovflow, cnt};

	always_ff @(posedge clk) begin
		if (rst | start) begin
			cnt <= 32'h00000000;
			ovflw <= 0;
			if (rst) ena <= 0;
			else if (start) ena <= 1;
		end 
		else if (stop) begin
			ena <= 0;
		end 
		else if (ena) begin
			if (cnt == 32'hffffffff) begin
				ovflw <= 1;
			end
			cnt <= cnt + 1;
		end
	end


endmodule : Timer