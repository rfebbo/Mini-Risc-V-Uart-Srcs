module tb_LAA_force();

logic clk, Rst, debug, rx, prog;
logic[ 4:0] debug_input; 
logic tx, clk_out; 
logic [6:0] sev_out;
logic [7:0] an;
logic [15:0] led; 
logic [95:0] key;

assign key[95:48]=48'h3cf3cf3cf3cf;
assign key[47:24]=24'h30c30c;
assign key[23:12]=12'hbae;
assign key[11:0]=12'h3cf;
rv_uart_top dut(.*);

always #5 clk=!clk; 

initial begin
    $display("Begin simulaton");
    clk = 0;
    Rst = 1; 
    debug = 0;
    rx = 0; 
    prog = 0;
    debug_input = 0; 
    #10;
    Rst=0;
    #50;
    
    force dut.rv_core.bus.LAA_ins = 'h00000000;
    force dut.rv_core.bus.ins     = 'h000017b7; #10; // a5 = 1
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    
    force dut.rv_core.bus.ins     = 'h00000000;
    force dut.rv_core.bus.LAA_ins = 'h7800010B; #10; // laa_A[0] = a5
    force dut.rv_core.bus.LAA_ins = 'h7A40010B; #10; // laa_B[0] = a5
    force dut.rv_core.bus.LAA_ins = 'h0000018B; #10; // multiply
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    force dut.rv_core.bus.LAA_ins = 'h7FC0008B; #10; // a5 = laa_ctrl
    
    force dut.rv_core.bus.LAA_ins = 'h00000000;
    force dut.rv_core.bus.ins     = 'hef478793; #10; // a5 = a5 - 268
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    
    force dut.rv_core.bus.ins     = 'h00000000;
    force dut.rv_core.bus.LAA_ins = 'h7800008B; #10; // a5 = laa_A[0]
    
    force dut.rv_core.bus.LAA_ins = 'h00000000;
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP
    force dut.rv_core.bus.ins     = 'h00000013; #10; // NOP

end

endmodule
