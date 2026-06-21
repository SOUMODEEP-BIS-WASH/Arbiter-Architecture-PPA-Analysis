`timescale 1ns / 1ps

module tb;

    reg [3:0]in_valid, grant;
    
    reg [1:0]dest1,dest2,dest3,dest4;
    
    reg [7:0]datain1,datain2,datain3,datain4;
    
    wire [7:0]dataout1,dataout2,dataout3,dataout4;
    
    wire [3:0]out_valid;
    
    cbs dut(in_valid,grant,dest1,dest2,dest3,dest4,datain1,
    datain2,datain3,datain4,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    initial begin
    
    grant=4'b0001; in_valid=4'b0001; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;  #10;
    $display("FOR 1st CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",dest1,datain1,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0001; in_valid=4'b0001; dest1=2'b01; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10; #10;
    $display("FOR 1st CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",dest1,datain1,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0001; in_valid=4'b0001; dest1=2'b10; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10; #10;
    $display("FOR 1st CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",dest1,datain1,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    
    grant=4'b0001; in_valid=4'b0001; dest1=2'b11; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;  #10;
    $display("FOR 1st CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",dest1,datain1,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0100; in_valid=4'b0100; dest1=2'b10; dest2=2'b10; dest3=2'b00; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10; #10;
    $display("FOR 3rd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest3,datain3,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0100; in_valid=4'b0100; dest1=2'b00; dest2=2'b10; dest3=2'b01; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10; #10;   
    $display("FOR 3rd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest3,datain3,dataout1,dataout2,dataout3,dataout4,out_valid);
        
    grant=4'b0100; in_valid=4'b0100; dest1=2'b00; dest2=2'b10; dest3=2'b10; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;     
    $display("FOR 3rd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest3,datain3,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0100; in_valid=4'b0100; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 3rd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest3,datain3,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b1000; in_valid=4'b1000; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b00;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 4th CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest4,datain4,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b1000; in_valid=4'b1000; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 4th CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest4,datain4,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b1000; in_valid=4'b1000; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b10;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 4th CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest4,datain4,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b1000; in_valid=4'b1000; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b11;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;  #10;
    $display("FOR 4th CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest4,datain4,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0010; in_valid=4'b0010; dest1=2'b11; dest2=2'b00; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;  #10;
    $display("FOR 2nd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest2,datain2,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0010; in_valid=4'b0010; dest1=2'b00; dest2=2'b01; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 2nd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest2,datain2,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0010; in_valid=4'b0010; dest1=2'b00; dest2=2'b10; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 2nd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest2,datain2,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    grant=4'b0010; in_valid=4'b0010; dest1=2'b00; dest2=2'b11; dest3=2'b11; dest4=2'b01;
    datain1=8'd8;datain2=8'd5;datain3=8'd9;datain4=8'd10;#10;
    $display("FOR 2nd CPU GRANT | DEST = %2b | DATAIN = %8b | OUT1 = %8b | OUT2 = %8b | OUT3 = %8b | OUT4 = %8b | OUTVALID = %4b",
    dest2,datain2,dataout1,dataout2,dataout3,dataout4,out_valid);
    
    $finish;
    
    end

endmodule
