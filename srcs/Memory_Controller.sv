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

logic [31:0] uart_dout;
//logic [31:0] uart_din;
logic [31:0] uart_ctrl; //uart_ctrl[0] = w_ready, uart_ctrl[1] = r_valid

logic disp_wea;
logic [31:0] disp_dat;

logic [31:0] imem_addr, imem_dout, imem_din; 
logic imem_en, imem_state;

logic r_valid, w_ready, r_valid_in, w_ready_in;
logic rw_en;
logic [7:0] txdata;




always_comb begin
    clk = rbus.clk;
    rst = rbus.Rst; 
    mem_wea = rbus.mem_wea;
    mem_din = rbus.mem_din; 
//    rbus.mem_dout = mem_dout;
    
    mem_addr_lower = rbus.mem_addr[11:0]; 
    mem_addr_upper = rbus.mem_addr[31:12]; 
    mem_en = (mem_addr_upper == 20'h0) ? rbus.mem_en : 4'b0000; 
    imem_en = rbus.imem_en; 
    imem_addr = rbus.imem_addr; 
    imem_din = rbus.imem_din; 
    rbus.imem_dout = imem_dout;
//    uart_dout = {24'h0, mbus.rxdata};
//    uart_ctrl = {30'h0, mbus.r_valid_out, mbus.w_ready_out};
    mbus.rw_en = rw_en;
//    mbus.txdata = uart_din[7:0];
    mbus.txdata = txdata;
    uart_ctrl = {30'h0, r_valid, w_ready};
    uart_dout = {24'h0, mbus.rxdata};
    
//    rbus.mem_dout = ( mem_addr_upper == 20'haaaaa ) ? (uart_dout ): mem_dout;
//    mbus.w_ready_write = ((mem_addr_upper == 20'haaaaa) && (mem_addr_lower == 12'h010) && (mem_din[1] == 1)) ? 1'b1 : 1'b0;
//    mbus.r_valid_write = ((mem_addr_upper == 20'haaaaa) && (mem_addr_lower == 12'h010) && (mem_din[0] == 1)) ? 1'b1 : 1'b0;
//    r_valid = ((mem_addr_upper == 20'haaaaa) && (mem_addr_lower == 12'h010)) ? mem_din[1] : r_valid_in;
//    w_ready = ((mem_addr_upper == 20'haaaaa) && (mem_addr_lower == 12'h010)) ? mem_din[0] : w_ready_in;
//    r_valid = mem_din[1];
//    w_ready = mem_din[0]; 
end

//assign mbus.rw = mbus.rw_en ? {r_valid, w_ready} : 2'bz; 
//assign mbus.rw = rw_en ? mem_din[1:0] : 2'b00;
////assign mbus.rw = mbus.rw_en ? 2'b00 : 2'bz;
//assign r_valid_in = mbus.rw[1];
//assign w_ready_in = mbus.rw[0]; 
assign r_valid = mbus.rw[1];
assign w_ready = mbus.rw[0]; 
assign mbus.rw_in = rw_en ? mem_din[1:0] : {r_valid, w_ready};

assign rw_en = ((mem_addr_upper == 20'haaaaa) && (mem_addr_lower == 12'h010)) ? mem_wea : 1'b0;
//assign rw_en = 1'b0;
always_comb begin
    mbus.disp_wea = disp_wea;
    mbus.disp_dat = disp_dat; 
//    rw_en = 0;
    if (mem_addr_upper == 20'haaaaa) begin
        case (mem_addr_lower) 
            12'h010: begin 
                rbus.mem_dout = uart_ctrl;
//                rw_en = mem_wea;
//                if (mem_wea == 1) begin
//                    if (mem_din[1] == 1) mbus.w_ready_write = 1;
//                    else if (mem_din[0] == 1) mbus.r_valid_write = 1;
//                end
            end
            12'h014: rbus.mem_dout = {24'h0, txdata}; 
            12'h018: rbus.mem_dout = uart_dout;
            default: rbus.mem_dout = mem_dout;
        endcase
    end else rbus.mem_dout = mem_dout;
end

always_ff @(posedge clk) begin
    if (rst) begin
        txdata = 0;
    end else begin
//        mbus.r_valid_write = 0;
//        mbus.w_ready_write = 0;
        if ((mem_wea == 1) && (mem_addr_upper == 20'haaaaa)) begin 
            if ((mem_addr_lower == 12'h004)) begin //disp wea
                disp_wea = mem_din[0]; 
            end
            else if ((mem_addr_lower == 12'h008)) begin //disp data
                disp_dat = mem_din;
            end
            else if ((mem_addr_lower == 12'h00c)) begin //led data
                mbus.led = mem_din[15:0];
            end
            else if ((mem_addr_lower == 12'h014)) begin
                txdata = mem_din[7:0];
            end
//            else if ((mem_addr_lower == 12'h010)) begin //write
//                if (mem_din[1] == 1) mbus.w_ready_write = 1;
//                else if (mem_din[0] == 1) mbus.r_valid_write = 1;
//            end
//            else if ((mem_addr_lower == 12'h014)) begin //txdata
//                uart_din = mem_din;
//            end 
        end
    end
end

Memory_byteaddress mem0(.clk(clk), .rst(rst), .wea(mem_wea), .en(mem_en), .addr(mem_addr_lower), 
    .din(mem_din), .dout(mem_dout));
    
blk_mem_gen_0 imem0(.clka(clk), .ena(imem_en), .wea(4'b0000), .addra(imem_addr), .dina(32'hz), 
    .douta(imem_dout));
//IRAM_Controller imem0(.clk(clk), .rst(rst), .ena(imem_en), .prog_ena(rbus.imem_prog_ena), 
//    .wea_in(4'b0000), .dina(imem_din), .addr_in(imem_addr), .state_load_prog(imem_state),
//    .douta(imem_dout));
    

endmodule : Memory_Controller