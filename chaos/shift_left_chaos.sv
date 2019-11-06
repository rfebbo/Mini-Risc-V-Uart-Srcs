`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 12:24:14 AM
// Design Name: 
// Module Name: shift_left_chaos
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


module shift_left_chaos(
    input  logic [31:0] a,
    input  logic [4:0]  shamt,
    input  logic [23:0] key,
    output logic [31:0] y
    );
    logic imd [127:0];
    genvar i;
    genvar j;
    //integer k;
    generate
        for(i=0;i<5;i++)
        begin
            for(j=0;j<32;j++)
            begin
                if (i==0)
             
                    if(j<2**i)
                        mux gen_inst (.a(a[j]),.b(1'b0),.sel(shamt[i]),.y(imd[i*32+j]));
                    else
                        mux gen_inst (.a(a[j]),.b(a[j-2**i]),.sel(shamt[i]),.y(imd[i*32+j])); 
                else if (i==4)
                    if(j<2**i)
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(1'b0),.sel(shamt[i]),.y(y[j]));
                    else
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j-2**i]),.sel(shamt[i]),.y(y[j])); 
                else if (i inside {2,3})
                    
                    if(j<2**i)
                        mux_chaos gen_inst(.a(imd[(i-1)*32+j]),.b(1'b0),.key(key[((j/16)+1+2*(i-2))*6-1:((j/16)+2*(i-2))*6]),.sel(shamt[i]),.y(imd[i*32+j]));
                    else
                        mux_chaos gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j-2**i]),.key(key[((j/16)+1+2*(i-2))*6-1:((j/16)+2*(i-2))*6]),.sel(shamt[i]),.y(imd[i*32+j])); 
                else
                    
                    if(j<2**i)
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(1'b0),.sel(shamt[i]),.y(imd[i*32+j]));
                    else
                        mux gen_inst(.a(imd[(i-1)*32+j]),.b(imd[(i-1)*32+j-2**i]),.sel(shamt[i]),.y(imd[i*32+j]));                 
                                    
                    
                         
            end
        end
    endgenerate
    
endmodule
