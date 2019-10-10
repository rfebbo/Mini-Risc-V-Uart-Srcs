`timescale 1ns / 1ps 

module CSR (
	main_bus bus
	);

    logic clk, wea;
    logic[31:0] din, dout; 
    logic [11:0] r_addr, w_addr;
    
    logic [31:0] csr_reg [4095:0];
    
    always_comb begin
        clk = bus.clk; 
        wea = bus.MEM_WB_CSR_write;
        r_addr = bus.IF_ID_CSR_addr; 
        w_addr = bus.MEM_WB_CSR_addr;
        din = bus.WB_CSR_res;
        bus.IF_ID_CSR_dout = dout;
    end
    
    assign dout = csr_reg[r_addr];
    
    always_ff @(posedge clk) begin
        if (wea == 1) begin
            csr_reg[w_addr] = din;
        end
        
    end

endmodule : CSR