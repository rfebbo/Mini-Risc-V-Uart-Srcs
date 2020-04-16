`timescale 1ns / 1ps 

module CSR (
	main_bus bus
	);

    logic clk, wea, rst;
    logic[31:0] din, dout; 
    logic [11:0] r_addr, w_addr;
    
    always_comb begin: bus_stuff
        clk = bus.clk;
        rst = bus.Rst;
        wea = bus.EX_CSR_write;
        din = bus.EX_CSR_res;
        r_addr = bus.IF_ID_CSR_addr;
        w_addr = bus.EX_CSR_addr; 
        bus.IF_ID_CSR = dout;
    end
    
    enum logic[11:0] {
        mstatus     = 12'h300, 
        misa        = 12'h301,
        mie         = 12'h304,
        mtvec       = 12'h305, 
        
        mscratch    = 12'h340,
        mepc        = 12'h341, 
        mcause      = 12'h342, 
        mtval       = 12'h343, 
        mip         = 12'h344
        } csr_list;
    
    logic [31:0] csr [logic [11:0]];
//    csr_listings cidx;
    
    initial begin
        csr_list = csr_list.first; 
        do begin
            csr[csr_list] = 32'h0;
            csr_list = csr_list.next; 
        end while (csr_list != csr_list.first);
        
        csr[misa] = 32'h40000100;
        
//        foreach (csr[i]) begin
//            $display("csr[%0x] = %0x", i , csr[i]);
//        end
    end
    
    //Right now, only possible mcause is built from ra stack trap
    function logic[31:0] build_mcause();
    begin
        return {1'b0, bus.stack_mismatch, 30'h0};
    end
    endfunction
    
    always_comb begin
        if (csr.exists(r_addr)) begin
            dout <= csr[r_addr];
        end else begin
            dout <= 32'h0; 
        end
        bus.mtvec <= csr[mtvec];
    end
    
    event triggered;
    
    always_ff @(posedge clk) begin
        if (rst) begin
        
        end else begin
            if (bus.trap) begin
               csr[mepc] <= bus.IF_ID_pres_addr; 
               ->triggered;
//               csr[mcause] <= build_mcause();
//               triggerTrap();
            end else begin
//                if (bus.ecall) triggerTrap();
                if (wea) begin
                    if (csr.exists(w_addr))
                        csr[w_addr] <= din;
                end
            end
        end
    end
    
    always @(posedge bus.stack_mismatch) begin
        triggerTrap();
    end
    
    always @(posedge bus.ecall) triggerTrap();
    

    
    task triggerTrap();
    begin
        
        csr[mcause] <= build_mcause();
        bus.trap = 1;
        
        @ (triggered); 
        bus.trap = 0;
    end
    endtask
    
    
//    always_comb begin
//        bus.csr = csr;
//    end
    
    
//    logic [31:0] csr_reg [4095:0];
    
//    always_comb begin
//        clk = bus.clk; 
//        wea = bus.MEM_WB_CSR_write;
//        r_addr = bus.IF_ID_CSR_addr; 
//        w_addr = bus.MEM_WB_CSR_addr;
//        din = bus.WB_CSR_res;
//        bus.IF_ID_CSR_dout = dout;
//    end
    
//    assign dout = csr_reg[r_addr];
    
//    always_ff @(posedge clk) begin
//        if (wea == 1) begin
//            csr_reg[w_addr] = din;
//        end
        
//    end

endmodule : CSR