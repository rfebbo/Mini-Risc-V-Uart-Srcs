`timescale 1ns / 1ps 

module Memory_Controller (
    riscv_bus rbus, 
    mmio_bus mbus
);

logic clk, rst;
logic mem_wea;
logic [3:0] mem_en;
logic [11:0] mem_addr_lower;
logic [19:0] mem_addr_upper;
logic [31:0] mem_din, mem_dout; 

logic disp_wea;
logic [31:0] disp_dat;

always_comb begin
    clk = rbus.clk;
    rst = rbus.Rst; 
    mem_wea = rbus.mem_wea;
    mem_din = rbus.mem_din; 
    rbus.mem_dout = mem_dout; 
    mem_addr_lower = rbus.mem_addr[11:0]; 
    mem_addr_upper = rbus.mem_addr[31:12]; 
    mem_en = (mem_addr_upper == 19'h0) ? rbus.mem_en : 4'b0000; 
end

always_comb begin
    mbus.disp_wea = disp_wea;
    mbus.disp_dat = disp_dat; 
    
end

always_ff @(posedge clk) begin
    if (rst) begin
    
    end else begin
        if ((mem_wea == 1) && (mem_addr_upper == 20'haaaaa)) begin 
            if ((mem_addr_lower == 12'h004)) begin
                disp_wea = mem_din[0]; 
            end
            else if ((mem_addr_lower == 12'h008)) begin
                disp_dat = mem_din;
            end
        end
    end
end

Memory_byteaddress mem0(.clk(clk), .rst(rst), .wea(mem_wea), .en(mem_en), .addr(mem_addr_lower), 
    .din(mem_din), .dout(mem_dout));
    

endmodule : Memory_Controller