`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Garrett S. Rose. Grayson Bruner
//   University of Tennessee, Knoxville
// 
// Created:
//   May 20, 2019
// 
// Module name: Memory_Controller
// Description:
//   Memory controller used to read from and program instruction memory. 
//   Enters programming mode when the hexadecimal code "deadbeef" is
//   received from UART. From there each subsequent 32-bit hex code is
//   stored sequentially in memory. The end of the new program is 
//   denoted by the hexadecimal code "baddab99"
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   rst -- reset
//   ena -- read enable
//   prog_ena -- program enable
//   wea_in -- write enable. This input is currently ignored
//   addr_in -- read address from fetch pipeline stage. Ignored while programming
// Output:
//   state_load_prog -- high when memory controller is in its reprogramming state
//   douta -- output from instruction memory. Instruction at requested address, or 
//       last programmed address when reprogramming
// 
//////////////////////////////////////////////////////////////////////////////////



module Memory_Controller(
    input logic clk, rst, ena, prog_ena,
    input logic[3:0] wea_in,
    input logic[31:0] dina,
    input logic[9:0] addr_in, 
    output logic state_load_prog,
    output logic[31:0] douta
    );
    
    enum {std_op, load_prog} state;
    logic[9:0] addra;
    logic[3:0] wea;
    logic mem_ena;
    logic mem_clk;
    logic posclk, negclk; //this could probably be fixed... These are needed so that the memory itself doesn't
                          //receive the clock edge until this module prepares the necessary control signals. 
                          //posclk toggles at the positive edge of the clock AFTER this module has prepared
                          //the necessary control signals. 
                          //negclk toggles at the negative edge of the clock.
                          //XORing the two gives a clock with an identical period to the input one while delaying
                          //it long enough for the control signals to change as needed. 
    
    assign mem_clk = posclk^negclk;
    assign mem_ena = (ena || prog_ena);
    
    always @(state) 
        case(state)
            load_prog: state_load_prog <= 1;
            std_op : state_load_prog <= 0;
            default: state_load_prog <= 0;
        endcase
        
    blk_mem_gen_0 mem(.clka(mem_clk), .ena(mem_ena), .*);

            
    always_ff @(posedge clk) begin
        if (rst) begin
            addra = 10'b0000000000;
            wea = 4'b0000;
            state = std_op;
            posclk = 1'b0;
//            mem_ena = ena;
        end
        else begin
//            if (ena) begin
            case(state)
                load_prog:begin
                    if (prog_ena) begin
                        if (dina == 32'hbaddab99) begin
                            state <= std_op;
                            //addra = 6'b000000;
                            addra = addr_in;
                            wea = 4'b0000;
                        end
                        else begin
                            wea = 4'b1111;
                            addra++;
//                            state = incr_load_addr;
                        end
                    end
                    else
                        wea = 4'b0000;
                end
                std_op:begin
                    if ((dina == 32'hdeadbeef) && prog_ena) begin
                        state = load_prog;
                        //addra = 6'b000000;
                        addra = 10'b1111111111;                            
                    end
                    else if (ena) begin
                        addra = addr_in;
                        wea = wea_in; 
                    end
                    else
                        wea = 4'b0000;
                end
            endcase
            posclk = ~posclk;
        end
    end
    
    always_ff @(negedge clk)
        if (rst) begin
            negclk = 1;
        end
        else negclk = ~negclk;
    
endmodule
