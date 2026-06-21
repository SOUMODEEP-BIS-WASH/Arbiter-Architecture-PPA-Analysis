`timescale 1ns / 1ps


module cbs(
    
    input [3:0]in_valid,
    input [3:0]grant,
    
    input [1:0]dest1,dest2,dest3,dest4,
    
    input [7:0]datain1,datain2,datain3,datain4,
    
    output reg [7:0]dataout1,dataout2,dataout3,dataout4,
    
    output reg [3:0]out_valid
    );
    
    always @(*) begin
    
    out_valid=4'b0000;
    
    dataout1=0;
    dataout2=0;
    dataout3=0;
    dataout4=0;
    
    if(grant[0]) begin
    case(dest1)
    2'b00: begin dataout1=datain1; out_valid[0]=in_valid[0]; end
    2'b01: begin dataout2=datain1; out_valid[1]=in_valid[0]; end
    2'b10: begin dataout3=datain1; out_valid[2]=in_valid[0]; end
    2'b11: begin dataout4=datain1; out_valid[3]=in_valid[0]; end
    endcase
    end
    
    else if(grant[1]) begin
    case(dest2)
    2'b00: begin dataout1=datain2; out_valid[0]=in_valid[1]; end
    2'b01: begin dataout2=datain2; out_valid[1]=in_valid[1]; end
    2'b10: begin dataout3=datain2; out_valid[2]=in_valid[1]; end
    2'b11: begin dataout4=datain2; out_valid[3]=in_valid[1]; end
    endcase
    end
    
    else if(grant[2]) begin
    case(dest3)
    2'b00: begin dataout1=datain3; out_valid[0]=in_valid[2]; end
    2'b01: begin dataout2=datain3; out_valid[1]=in_valid[2]; end
    2'b10: begin dataout3=datain3; out_valid[2]=in_valid[2]; end
    2'b11: begin dataout4=datain3; out_valid[3]=in_valid[2]; end
    endcase
    end
    
    else if(grant[3]) begin
    case(dest4)
    2'b00: begin dataout1=datain4; out_valid[0]=in_valid[3]; end
    2'b01: begin dataout2=datain4; out_valid[1]=in_valid[3]; end
    2'b10: begin dataout3=datain4; out_valid[2]=in_valid[3]; end
    2'b11: begin dataout4=datain4; out_valid[3]=in_valid[3]; end
    endcase
    end
    
    end
     
endmodule
