`timescale 1ns / 1ps


module ta(
    input [3:0]req,
    input clk,rst,
    output [3:0]grant
    );
    
    wire dummy;
    wire requ1,requ2;
    wire g31,g32;
    wire [3:0]g;
    
    arb2_1 a3(clk,rst,requ1,requ2,1'b1,g31,g32,dummy);
    
    arb2_1 a1(clk,rst,req[0],req[1],g31,g[0],g[1],requ1);
    arb2_1 a2(clk,rst,req[2],req[3],g32,g[2],g[3],requ2);
    
    assign grant=g;
    
endmodule


