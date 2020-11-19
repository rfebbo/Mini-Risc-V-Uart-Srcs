`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 01:21:51 PM
// Design Name: 
// Module Name: LAA_core
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
// take ins from fetch stage (check )
/*
		input LAA_ins, 
		input clk, Rst,
		input IF_ID_dout_rs1, IF_ID_dout_rs2,
		output MEM_WB_rd, adr_rs1, IF_ID_rs2,
		output WB_res, MEM_WB_regwrite
*/
//////////////////////////////////////////////////////////////////////////////////


module LAA_core( main_bus bus);

    LAA_opcode laa_opcode; // NONE=0, READ=1, WRITE=2, MULTIPLY=3
    logic [4:0] addr_corereg_in1; // address of core regfile register from where to read input data1
    logic [4:0] addr_corereg_in2; // address of core regfile register from where to read input data2
    logic [4:0] addr_laareg_in1; // address of LAA register to store read input data1
    logic [4:0] addr_laareg_in2; // address of LAA register to store read input data2
    logic [31:0] data_in1; // Data to be written
    logic [31:0] data_in2; // Data to be written
  
    logic [4:0] addr_corereg_out; // Store output of LAA to Core regfile
    logic [4:0] addr_laareg_out; // Read output of LAA from LAA register
    logic reg_write;
    
    logic illegal_ins;
    logic [1:0] cur_stage, next_stage;
    LAA_opcode temp_opcode;
    
    // LAA bus
    LAA_bus LAA_bus(.clk(bus.clk), .rst(bus.Rst));
    
    // LAA instantiation
    LAA LAA_inst (LAA_bus);
    
    assign bus.MEM_WB_regwrite = reg_write;
    assign bus.WB_res = LAA_bus.data_out; //data_out; // Output of LAA - read from LAA register 
    assign bus.MEM_WB_rd = addr_corereg_out;
    assign bus.adr_rs1 = addr_corereg_in1;
    assign bus.IF_ID_rs2 = addr_corereg_in2;
    
    assign LAA_bus.data_in = data_in1;
    //assign data_out = LAA_bus.data_out;
    assign LAA_bus.opcode = laa_opcode;
    
    assign illegal_ins = (bus.LAA_ins[6:0] != 7'b0001011);
    

    always_comb begin
    temp_opcode = NONE;
    addr_corereg_in1 = 'd0;
    addr_corereg_in2 = 'd0;
    addr_laareg_in1 = 'd0;
    addr_laareg_in2 = 'd0;
    data_in1 = 'd0;
    data_in2 = 'd0;
    addr_corereg_out = 'd0;
    addr_laareg_out = 'd0;
    reg_write = 'b0;
    if (!illegal_ins) begin
     unique case (bus.LAA_ins[11:7])
      5'b00010:               // Load/Write to LAA registers : [31:27] - core_reg, [26:22] - LAA_reg, [21:12] - 10 bits not used, [11:7] - 0010, [6:0] - 00001011
        begin
    		temp_opcode = WRITE;
    		addr_corereg_in1 = bus.LAA_ins[31:27];
    		addr_laareg_in1 = bus.LAA_ins[26:22];
    		data_in1 = bus.IF_ID_dout_rs1;
    		data_in2 = bus.IF_ID_dout_rs2;
    		addr_corereg_out = 'd0;
    		addr_laareg_out = 'd0;
    		reg_write = 'b0;
    		LAA_bus.addr = addr_laareg_in1;
        end
      5'b00001:               // Read from LAA/Store to RiscV core registers : [31:27] - LAA_reg, [26:22] - core_reg, [21:12] - 10 bits not used, [11:7] - 0001, [6:0] - 00001011
		begin
    		temp_opcode = READ;
    		addr_corereg_in1 = 'd0;
    		addr_laareg_in1 = 'd0;
    		data_in1 = 'd0;
    		data_in2 = 'd0;
    		addr_laareg_out = bus.LAA_ins[31:27];
    		addr_corereg_out = bus.LAA_ins[26:22];
    		reg_write = 'b0;
    		LAA_bus.addr = addr_laareg_out;
        end		
      5'b00011:               // Execute
		begin
    		temp_opcode = MULTIPLY;
    		addr_corereg_in1 = 'd0;
    		addr_corereg_in2 = 'd0;
    		addr_laareg_in1 = 'd0;
    		addr_laareg_in2 = 'd0;
    		data_in1 = 'd0;
    		data_in2 = 'd0;
    		addr_corereg_out = 'd0;
    		addr_laareg_out = 'd0;
    		reg_write = 'b0;
    		LAA_bus.addr = addr_laareg_out;
        end
 
     default:
       begin
    		temp_opcode = NONE;
    		addr_corereg_in1 = 'd0;
    		addr_corereg_in2 = 'd0;
    		addr_laareg_in1 = 'd0;
    		addr_laareg_in2 = 'd0;
    		data_in1 = 'd0;
    		data_in2 = 'd0;
    		addr_corereg_out = 'd0;
    		addr_laareg_out = 'd0;
    		reg_write = 'b0;
    		LAA_bus.addr = addr_laareg_out;
       end        
     endcase
    end
    end


	always_ff @ (posedge bus.clk) begin
		if (bus.Rst) begin
			bus.LAA_busy <= 'b0;
			cur_stage <= 'd0;
			next_stage <= 'd0;
		end else begin
			cur_stage <= next_stage;
			next_stage <= bus.LAA_ins[8:7];
			laa_opcode = temp_opcode;
			bus.LAA_busy <= 'b0;
			if (next_stage == 2'b11) begin
		   		if ((LAA_bus.addr == 5'b1_1111) && (|(LAA_bus.data_out))) bus.LAA_busy <= 'b0;
		   		else bus.LAA_busy <= 'b1;
				if ((cur_stage == 2'b11) ) begin
					laa_opcode <= READ;
   		 			LAA_bus.addr <= 5'b1_1111;
   		 		end
			end
		end
	end


endmodule:LAA_core
