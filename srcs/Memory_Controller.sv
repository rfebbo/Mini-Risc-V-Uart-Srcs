`timescale 1ns / 1ps 

module Memory_Controller (
    riscv_bus rbus, 
    mmio_bus mbus
);

logic clk, rst;
logic mem_wea, mem_rea;
logic [3:0] mem_en;
logic [11:0] mem_addr_lower;
logic [19:0] mem_addr_upper;
logic [31:0] mem_din, mem_dout; 

logic disp_wea;
logic [31:0] disp_dat;

logic [31:0] imem_addr, imem_dout, imem_din; 
logic imem_en, imem_state;

logic mmio_region;
logic [31:0] blkmem_dout; 
logic [7:0] uart_dout;
logic uart_last_cond;

always_comb begin
    clk = rbus.clk;
    rst = rbus.Rst; 
    mem_wea = rbus.mem_wea;
    mem_rea = rbus.mem_rea;
    mem_din = rbus.mem_din; 
    rbus.mem_dout = mem_dout; 
    mem_addr_lower = rbus.mem_addr[11:0]; 
    mem_addr_upper = rbus.mem_addr[31:12]; 
    mem_en = (mem_addr_upper < 20'haaaaa) & (mem_wea) ? rbus.mem_en : 4'b0000; 
    imem_en = rbus.imem_en; 
    imem_addr = rbus.imem_addr; 
    imem_din = rbus.imem_din; 
    rbus.imem_dout = imem_dout;
    
    mmio_region = (mem_addr_upper == 20'haaaaa); 
end

always_comb begin
    mbus.disp_wea = disp_wea;
    mbus.disp_dat = disp_dat; 
    
end

always_comb begin
//    if (mmio_region) begin
//        if ((mem_addr_lower == 12'h400) & (mem_wea == 1)) begin
            
//        end
//    end
    mbus.tx_wen = (mmio_region & (mem_addr_lower == 12'h400)) ? mem_wea : 1'b0;
    mbus.uart_din = (mmio_region & (mem_addr_lower == 12'h400)) ? mem_din[7:0] : 8'h00;
//    if (mmio_region) begin
//        if (mem_addr_lower == 12'h400) begin
//            mem_dout = mbus.uart_dout;
//        end else if (mem_addr_lower == 12'h404) begin
//            mem_dout = {7'b0000000, mbus.rx_data_present};
//        end else begin
//            mem_dout = blkmem_dout;
//        end
//    end else begin
//        mem_dout = blkmem_dout;
//    end
    mem_dout = uart_last_cond ? uart_dout : blkmem_dout;
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
            else if ((mem_addr_lower == 12'h00c)) begin
                mbus.led = mem_din[15:0];
            end
        end
        if (mmio_region && ((mem_addr_lower == 12'h400) || (mem_addr_lower == 12'h404))) begin
            uart_last_cond <= 1;
            if (mem_addr_lower == 12'h400) uart_dout <= mbus.uart_dout; 
            else uart_dout <= mbus.rx_data_present;
        end else begin
            uart_last_cond <= 0; 
        end
    end
end



blk_mem_gen_1 sharedmem(.clka(clk), .ena(imem_en), .wea(4'b0000), .addra(imem_addr), .dina(32'hz), 
    .douta(imem_dout), .clkb(clk), .enb((mem_wea | mem_rea) & (~mmio_region)), 
    .web(mem_en), .addrb(rbus.mem_addr[12:2]), .dinb(mem_din), .doutb(blkmem_dout));

//Memory_byteaddress mem0(.clk(clk), .rst(rst), .wea(mem_wea), .en(mem_en), .addr(mem_addr_lower), 
//    .din(mem_din), .dout(mem_dout));
    
//blk_mem_gen_0 imem0(.clka(clk), .ena(imem_en), .wea(4'b0000), .addra(imem_addr), .dina(32'hz), 
//    .douta(imem_dout));
    
    
//IRAM_Controller imem0(.clk(clk), .rst(rst), .ena(imem_en), .prog_ena(rbus.imem_prog_ena), 
//    .wea_in(4'b0000), .dina(imem_din), .addr_in(imem_addr), .state_load_prog(imem_state),
//    .douta(imem_dout));
    

endmodule : Memory_Controller