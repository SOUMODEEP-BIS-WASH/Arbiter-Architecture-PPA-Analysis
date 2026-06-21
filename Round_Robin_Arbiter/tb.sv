`timescale 1ns/1ps

module tb;

reg [3:0]req;
reg clk=0,rst;
wire [3:0]grant;

RRA uut(clk,rst,req,grant);

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

    
    $finish;
end
    
   /*
   initial begin
    $monitor("T=%0t | RST=%b | REQ=%b | GRANT=%b", $time, rst, req, grant);

    rst = 1; req = 4'b1111;
    repeat(2) @(posedge clk);

    rst = 0;
    repeat(12) begin
        @(posedge clk);
        req = 4'b1111;
    end

    @(negedge clk); req = 4'b1000;
    @(negedge clk); req = 4'b0100;
    @(negedge clk); req = 4'b0010;
    @(negedge clk); req = 4'b0001;
    @(negedge clk); req = 4'b0010;
    @(negedge clk); req = 4'b0100;
    @(negedge clk); req = 4'b1000;
    @(negedge clk); req = 4'b0000;

    repeat(3) @(posedge clk);

    $finish;
end
*/

endmodule