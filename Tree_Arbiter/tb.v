/*
`timescale 1ns/1ps

module tb;

reg [1:0]req;
reg clk=0,rst,en;
wire [1:0]grant;
wire requ;

arb2_1 uut(clk,rst,req[0],req[1],en,grant[0],grant[1],requ);

always #5 clk=~clk;

initial begin

    $monitor("| TIME = %4t | RST = %b | REQ = %4b | GRANT = %4b | %b",$time,rst,req,grant,requ);

    rst=1; en =1'b1; req=2'b11; #10;
    
    rst=0; en=1'b1; req=2'b11; #10;
    rst=0; en=1'b1; req=2'b11; #10;
    rst=0; en=1'b1; req=2'b11; #10;

    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;

    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;

    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;
    rst=0; en=1'b1;req=2'b11; #10;


    rst=0; en=1'b1; req=2'b10; #10;
    rst=0; en=1'b1; req=2'b01; #10;
    rst=0; en=1'b1; req=2'b10; #10;
    rst=0; en=1'b1; req=2'b01; #10;
    rst=0; en=1'b1; req=2'b10; #10;
    rst=0; en=1'b1;req=2'b01; #10;
    rst=0; en=1'b1;req=2'b10; #10;
    rst=0; en=1'b1;req=2'b00; #10;
    
    $finish;
end
    
endmodule
*/


`timescale 1ns/1ps

module tb2;

reg [3:0]req;
reg clk=0,rst;
wire [3:0]grant;

ta uut(req,clk,rst,grant);

always #5 clk=~clk;

initial begin

    $monitor("| TIME = %4t | RST = %b | REQ = %4b | GRANT = %4b |",$time,rst,req,grant);

    rst=1; req=4'b1111; #10;
    
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;

    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;

    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;

    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;

    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;
    rst=0; req=4'b1111; #10;


    rst=0; req=4'b1000; #10;
    rst=0; req=4'b0100; #10;
    rst=0; req=4'b0010; #10;
    rst=0; req=4'b0001; #10;
    rst=0; req=4'b0010; #10;
    rst=0; req=4'b0100; #10;
    rst=0; req=4'b1000; #10;
    rst=0; req=4'b0000; #10;
    
    $finish;
end
    
endmodule
