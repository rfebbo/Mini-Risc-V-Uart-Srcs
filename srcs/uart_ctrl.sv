`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 03:55:48 PM
// Design Name: 
// Module Name: uart_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_ctrl(
/*        input logic clk, rst, rx, //w_ready_write,
        input logic rw_en, 
        //output w_ready_out,
        //input r_valid_write,
        //output r_valid_out,
//        inout logic w_ready, r_valid,
        inout logic [1:0] rw, 
        input logic [7:0] txdata,
        output logic [7:0] rxdata,
        output logic tx*/
        mmio_bus mbus
    );
    
    logic clk, rst, rx, tx, rw_en;
    logic [7:0] txdata, rxdata; 
    
    always_comb begin
        clk = mbus.clk;
        rst = mbus.Rst; 
        rx = mbus.rx;
        txdata = mbus.txdata;
        rw_en = mbus.rw_en;
        mbus.tx = tx;
        mbus.rxdata = rxdata;
        
    end
    
    enum {init, ena} state;
    
    logic aclk, aresetn, interrupt, awvalid, awready;
    logic wvalid, wready, bvalid, bready, arvalid, arready;
    logic rvalid, rready; 
    logic [3:0] awaddr, wstrb, araddr;
    logic [31:0] wdata, rdata; 
    logic [1:0] bresp, rresp;
    
    //logic w_ready_in, w_ready_out, r_valid_in, r_valid_out; 
    logic drive_w_ready, drive_r_valid;
    logic w_ready_last;
    logic intr_ena, tx_full, tx_empty, rx_full, rx_valid;
    logic w_hold, r_hold;
    logic r_status; 
        
    logic w_ready, r_valid;
    logic w_ready_in, r_valid_in;
//    assign w_ready = w_ready_write ? 1'b0 : w_ready; 
    //assign w_ready_out = w_ready; 
    
//    assign r_valid = r_valid_write ? 1'b0 : r_valid; 
    //assign r_valid_out = r_valid;
    
    assign mbus.rw = {r_valid, w_ready}; 
    assign r_valid_in = mbus.rw_in[1]; 
    assign w_ready_in = mbus.rw_in[0];
//    assign mbus.rw = rw_en ? 2'bz : {r_valid, w_ready};
//    assign mbus.rw = rw_en ? 2'b00 : {r_valid, w_ready};
//    assign r_valid_in = mbus.rw[1];
//    assign w_ready_in = mbus.rw[0];
////    assign w_ready = drive_w_ready ? w_ready_out : 1'bz;
//    assign w_ready = drive_w_ready ? w_ready_out : (w_write ? : w_ready);
//    assign w_ready_in = (w_ready == 1 || w_ready == 0) ? w_ready : w_ready_last; 
    
//    assign r_valid = drive_r_valid ? r_valid_out : 1'bz;
////    assign r_valid = drive_r_valid ? r_valid_out : r_valid;
//    assign r_valid_in = (r_valid == 1 || r_valid == 0) ? r_valid : r_valid_in; 
    
    
    assign aclk = clk;
    assign aresetn = ~rst; 
    assign wstrb = 4'b1111; 
    
    always_ff @(posedge clk) begin
        if (rst == 1) begin 
            r_valid <= 0;
            w_ready <= 0; 
            drive_w_ready <= 1;
            drive_r_valid <= 1;
            w_hold <= 0;
            r_hold <= 0;
            r_status <= 0;
            tx_full <= 0;
            tx_empty <= 1;
            rx_full <= 0;
            rx_valid <= 0;
            rxdata <= 0;
            state <= init;
        end else begin
//            if (w_ready_write == 1) w_ready <= 0; 
//            if (r_valid_write == 1) r_valid <= 0;
//            r_valid <= r_valid_in;
//            w_ready <= w_ready_in;
            case (state) 
                init : begin
                    if (w_hold == 0) begin
                        r_valid <= 0;
                        w_ready <= 0;
                        awaddr <= 4'hc; 
                        wdata <= 8'h13; 
                        awvalid <= 1;
                        wvalid <= 1; 
                        w_hold <= 1;
                    end 
                    if (awvalid == 1 && awready == 1) begin
                        awvalid <= 0;
                    end
                    if (wvalid == 1 && wready == 1) begin
                        wvalid <= 0; 
                        bready <= 1;
                    end
                    if (bvalid == 1 && bready == 1) begin
                        bready <= 0; 
                        drive_w_ready <= 1;
                        w_ready <= 1;
                        r_valid <= 0;
                        w_hold <= 0;
                        state <= ena; 
                    end 
//                    else begin
//                        drive_w_ready <= 0; 
//                    end
                end
                ena : begin
                    if (w_hold == 0) begin
                        drive_w_ready <= 0;
                        if (w_ready_in == 0 && tx_full == 0) begin
                            awaddr <= 4'h4;
                            wdata <= txdata; 
                            awvalid <= 1;
                            wvalid <= 1;
                            w_hold <= 1; 
                            w_ready <= 0;
                        end
                    end else if (w_hold == 1) begin
                        if (awvalid == 1 && awready == 1) begin
                            awvalid <= 0;
                        end
                        if (wvalid == 1 && wready == 1) begin
                            wvalid <= 0;
                            bready <= 1; 
                        end
                        if (bready == 1 && bvalid == 1) begin
                            bready <= 0;
                            w_hold <= 0; 
                            drive_w_ready <= 1;
                            w_ready <= 1;
                        end
                    end
                    
                    if (r_hold == 0) begin
                        drive_r_valid <= 0;
                        if (r_valid_in == 0 && rx_valid == 1) begin
                            araddr = 4'h0;
                            arvalid <= 1; 
                            r_hold <= 1;
                            r_status <= 0;
//                            r_valid <= 0;
                        end else begin
                            araddr = 4'h8;
                            arvalid <= 1;
                            r_hold <= 1;
                            r_status <= 1; 
                        end
                    end else if (r_hold == 1) begin
                        if (arvalid == 1 && arready == 1) begin
                            arvalid <= 0; 
                            rready <= 1;
                        end
                        if (rvalid == 1 && rready == 1) begin
                            rready <= 0; 
                            r_hold <= 0;
                            if (r_status == 1) begin
                                intr_ena <= rdata[4]; 
                                tx_full <= rdata[3];
                                tx_empty <= rdata[2];
                                rx_full <= rdata[1];
                                rx_valid <= rdata[0]; 
                            end else begin 
                                rxdata <= rdata[7:0]; 
                                drive_r_valid <= 1;
                                r_valid <= 1;
                                rx_valid <= 0;
                            end
                        end
                    end
//                    if (r_valid_in == 0 && rx_valid == 1 && r_hold == 0) begin
//                        araddr = 
//                    end
                    
                end
            endcase
        end
    end
    
    axi_uartlite_0 u0(.s_axi_aclk(aclk), .s_axi_aresetn(aresetn), .interrupt(interrupt),
        .s_axi_awaddr(awaddr), .s_axi_awvalid(awvalid), .s_axi_awready(awready), 
        .s_axi_wdata(wdata), .s_axi_wstrb(wstrb), .s_axi_wvalid(wvalid), .s_axi_wready(wready),
        .s_axi_bresp(bresp), .s_axi_bvalid(bvalid), .s_axi_bready(bready), .s_axi_araddr(araddr),
        .s_axi_arvalid(arvalid), .s_axi_arready(arready), .s_axi_rdata(rdata), 
        .s_axi_rresp(rresp), .s_axi_rvalid(rvalid), .s_axi_rready(rready), .rx(rx), .tx(tx)
        );
    
endmodule
