`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2019 12:17:35 PM
// Design Name: 
// Module Name: chao_2x1
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


module chao_2x1
    //#(parameter N = 64)
    (
    output logic       y,
    input  logic [1:0] x,
    input  logic [5:0] key
    
    );

//logic [0:0] c[0:15];
//`ifndef SYNTHESIS
//initial begin
//$readmemb("C:/Users/mmajumde/Documents/HOST_demo2019/Miscelleneous/chao_chip1.mem",c,0,15);
//end
//`endif
//`ifndef SYNTHESIS
//integer i;
integer c[256]={1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,0,0,0,0,1,1,0,0,0,0,1,1,0,1,0,0,1,0,0,1,0,1,1,0,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,1,1,0,1,0,0,1,0,0,1,0,0,1,0,1,1,0,0,0,0,1,1,0,1,0,0,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,0,1,1,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,0,0,0,1,1,0,1,0,0,1,0,0,1,0,1,1,0,1,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,0,1,1,0,1,0,0,1,0,0,1,0,0,1,0,1,1,0,0,0,0,1,1,1,1,0,0,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0};


//    initial begin
//        integer fd,status;
//        fd = $fopen("C:/Users/mmajumde/Documents/HOST_demo2019/Miscelleneous/lut_charac.csv", "r");
//        for(i=0;i<16;i++)begin
//            status=$fscanf(fd,"%d,",c[i]);
//        end
//        //$display("%d",status);
//        $fclose(fd);   
//    end
//`endif
always_comb begin
    for (int j=0; j<256; j++)begin
        if({key,x}==j)
            y=c[j];
    end
    
end
endmodule
