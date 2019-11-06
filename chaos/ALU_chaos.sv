`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 10:04:04 AM
// Design Name: 
// Module Name: ALU_chaos
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


module ALU_chaos(
    input   logic   [31:0]  a,
    input   logic   [31:0]  b,
    input   logic   [2:0]   opcode,
    input   logic   [95:0]  key,
    output  logic   [31:0]  y
    );

 
 
 logic [31:0] y_logic,y_arith,y_sr,y_sl;
 logic [11:0] key_logic,key_arith, key_and, key_or, key_xor;
 logic [23:0] key_sr, key_sl;
 
 assign key_and = key[11:0];
 assign key_or  = key[23:12];
 assign key_xor = key[35:24];
 assign key_arith = key[47:36];
 assign key_sl = key[71:48];
 assign key_sr = key[95:72];
 
 logical_chaos logical (.a(a),.b(b),.key(key_logic),.y(y_logic));
 add_sub_chaos arith (.a(a),.b(b),.c_in(opcode[0]),.key(key_arith),.sum(y_arith));
 shift_left_chaos shl (.a(a),.shamt(b[4:0]),.key(key_sl),.y(y_sl));
 shift_right_chaos shr (.a(a),.shamt(b[4:0]),.c(opcode[0]),.key(key_sr),.y(y_sr));

    
 
 always_comb
        case(opcode)
           3'b010 :  key_logic = key_and;
           3'b011 :  key_logic = key_or;
           3'b100 :  key_logic = key_xor;
           default:  key_logic = 12'h000;
         endcase     
 
 
    
 always_comb
        case(opcode)
          3'b000 : y = y_arith;
          3'b001:  y = y_arith;
          3'b010:  y = y_logic;
          3'b011:  y = y_logic; 
          3'b100:  y = y_logic;
          3'b101:  y = y_sl;
          3'b110:  y = y_sr;
          3'b111:  y = y_sr; 
        endcase   
endmodule
