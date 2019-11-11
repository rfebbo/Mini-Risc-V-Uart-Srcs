`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 01:25:24 PM
// Design Name: 
// Module Name: shift_right
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


module shift_right_chaos(
  input  logic        c,
  input  logic [31:0] a,
  input  logic [4:0]  shamt, //levels
  input  logic [23:0] key,
  output logic [31:0] y
    );
    
    
    logic imd [127:0];
    logic ctrl [31:0];
//    integer k = 0;
//    integer k = 0;
    generate
    
    genvar i;
    genvar j;
        for(i=0;i<5;i++)
        begin
            for(j=31;j>=0;j--)
            begin
                if (i==0) begin
             
                    if(j>31 - 2**i) begin
                       localparam k = (2**i - 1) + (32 - j);
                       mux gate0 (.a(1'b0),.b(a[31]),.sel(c),.y(ctrl[k]));
                       mux gen_inst (.a(a[j]),.b(ctrl[k]),.sel(shamt[i]),.y(imd[j]));
//                       k = k+1; 
                    end else
                        mux gen_inst (.a(a[j]),.b(a[j+2**i]),.sel(shamt[i]),.y(imd[j])); 
               end else if (i==4)
                    if(j>31-2**i) begin
                        localparam k = (2**i - 1) + (32 - j);
                        mux gate0 (.a(1'b0),.b(a[31]),.sel(c),.y(ctrl[k]));
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(ctrl[k]),.sel(shamt[i]),.y(y[j]));
//                        k  = k+1; 
                    end else
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j+2**i]),.sel(shamt[i]),.y(y[j]));
                  
                 else if (i inside{2,3})
                          
                          if(j>31-2**i) begin
                            localparam k = (2**i - 1) + (32 - j);
                              mux_chaos gate0 (.a(1'b0),.b(a[31]),.sel(c),.key(key[((j/16)+1+2*(i-2))*6-1:((j/16)+2*(i-2))*6]),.y(ctrl[k]));
                              mux_chaos gen_inst(.a(imd[(i-1)*32+j]),.b(ctrl[k]),.sel(shamt[i]),.key(key[((j/16)+1+2*(i-2))*6-1:((j/16)+2*(i-2))*6]),.y(imd[i*32+j]));
//                              k  = k+1; 
                          end else
                              mux gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j+2**i]),.sel(shamt[i]),.y(imd[i*32+j]));                          
                  
                else
                    
                    if(j>31-2**i) begin
                        localparam k = (2**i - 1) + (32 - j);
                        mux gate0 (.a(1'b0),.b(a[31]),.sel(c),.y(ctrl[k]));
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(ctrl[k]),.sel(shamt[i]),.y(imd[i*32+j]));
//                        k  = k+1; 
                    end else
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j+2**i]),.sel(shamt[i]),.y(imd[i*32+j]));                 
//              localparam k  = k+1;                    
            end
        end
    endgenerate
endmodule
