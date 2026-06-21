`timescale 1ns / 1ps

module ma(
    input clk,rst,
    input [3:0]req,
    output [3:0]grant
    );
    
    parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
    reg [2:0]NS,PS;
    reg w01, w02, w03, w12, w13, w23;
    reg [1:0]count=2'b00, count_n=2'b00;
    reg [3:0]g=4'b0000;;
    //wire w01_u,w02_u,w03_u,w12_u,w13_u,w23_u;
    //wire done;
    //wire [3:0]g_n;
    wire w01_e,w02_e,w03_e, w12_e,w13_e,w23_e;
    
    assign w01_e=((count==2'b11))?((g[0]&&(count==2'b11))?1'b0:(g[1]&&(count==2'b11))?1'b1:w01):w01;
    assign w02_e=((count==2'b11))?((g[0]&&(count==2'b11))?1'b0:(g[2]&&(count==2'b11))?1'b1:w02):w02;
    assign w03_e=((count==2'b11))?((g[0]&&(count==2'b11))?1'b0:(g[3]&&(count==2'b11))?1'b1:w03):w03;
    assign w12_e=((count==2'b11))?((g[1]&&(count==2'b11))?1'b0:(g[2]&&(count==2'b11))?1'b1:w12):w12;    
    assign w13_e=((count==2'b11))?((g[1]&&(count==2'b11))?1'b0:(g[3]&&(count==2'b11))?1'b1:w13):w13;
    assign w23_e=((count==2'b11))?((g[2]&&(count==2'b11))?1'b0:(g[3]&&(count==2'b11))?1'b1:w23):w23;
             
    always @(posedge clk or posedge rst) begin
    if(rst) begin PS<=s0; {w01,w02,w03,w12,w13,w23}<=6'b111111; count<=2'b00; end 
    else begin PS<=NS; count<=count_n;{w01,w02,w03,w12,w13,w23}<={w01_e,w02_e,w03_e,w12_e,w13_e,w23_e}; end
    end
    
    always @(*) begin
    //{w01,w02,w03,w12,w13,w23}={w01_u,w02_u,w03_u,w12_u,w13_u,w23_u};
    
    count_n=count;
    NS=PS;
    
    if (rst) begin g=4'b0000;
    count_n=2'b00;
    NS=s0; end
    
    else begin
    case (PS)
    
    s0: begin
    g=4'b0000;
    count_n=0;
    
    if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) NS=s1;
    else if(req[1]&(~w01_e|~req[0])&(w12_e|~req[2])&(w13_e|~req[3])) NS=s2;
    else if(req[2]&(~w02_e|~req[0])&(~w12_e|~req[1])&(w23_e|~req[3])) NS=s3;
    else if(req[3]&(~w03_e|~req[0])&(~w13_e|~req[1])&(~w23_e|~req[2])) NS=s4;
    else NS=s0;
    end
    
    s1: begin
    if(req[0]) begin
    g=4'b0001;
    if(count<2'b11) begin count_n=count+1'b1; NS=s1; end
    else begin 
    count_n=0;  
    if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) NS = s1;
    else if(req[1]&(~w01_e|~req[0])&(w12_e|~req[2])&(w13_e|~req[3])) NS = s2;
    else if(req[2]&(~w02_e|~req[0])&(~w12_e|~req[1])&(w23_e|~req[3])) NS = s3;
    else if(req[3]&(~w03_e|~req[0])&(~w13_e|~req[1])&(~w23_e|~req[2])) NS = s4;
    else NS=s0;
    end
    end
    else if(req[1]&(~w01|~req[0])&(w12|~req[2])&(w13|~req[3])) begin NS=s2; count_n=0; end
        else if(req[2]&(~w02|~req[0])&(~w12|~req[1])&(w23|~req[3]))begin NS=s3;count_n=0; end
            else if(req[3]&(~w03|~req[0])&(~w13|~req[1])&(~w23|~req[2]))begin NS=s4;count_n=0; end
                else begin NS=s0;count_n=0; end
    end
        
    s2: begin
    if(req[1]) begin
    g=4'b0010;
    if(count<2'b11) begin count_n=count+1'b1; NS=s2; end
    else begin count_n=1'b0;
    if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) NS = s1;
    else if(req[1]&(~w01_e|~req[0])&(w12_e|~req[2])&(w13_e|~req[3])) NS = s2;
    else if(req[2]&(~w02_e|~req[0])&(~w12_e|~req[1])&(w23_e|~req[3])) NS = s3;
    else if(req[3]&(~w03_e|~req[0])&(~w13_e|~req[1])&(~w23_e|~req[2])) NS = s4;
    else NS=s0;
    end
    end
    else if(req[0]&(w01|~req[1])&(w02|~req[2])&(w03|~req[3])) begin NS=s1;count_n=0; end
        else if(req[2]&(~w02|~req[0])&(~w12|~req[1])&(w23|~req[3])) begin NS=s3;count_n=0; end
            else if(req[3]&(~w03|~req[0])&(~w13|~req[1])&(~w23|~req[2])) begin NS=s4;count_n=0; end
                else begin NS=s0;count_n=0; end
    end
            
    s3:begin
    if(req[2])begin
    g=4'b0100;
    if(count<2'b11) begin count_n=count+1'b1; NS=s3; end
    else begin count_n=1'b0;
    if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) NS = s1;
    else if(req[1]&(~w01_e|~req[0])&(w12_e|~req[2])&(w13_e|~req[3])) NS = s2;
    else if(req[2]&(~w02_e|~req[0])&(~w12_e|~req[1])&(w23_e|~req[3])) NS = s3;
    else if(req[3]&(~w03_e|~req[0])&(~w13_e|~req[1])&(~w23_e|~req[2])) NS = s4;
    else NS=s0;
        end
    end
        else if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) begin NS=s1;count_n=0; end
        else if(req[1]&(~w01|~req[0])&(w12|~req[2])&(w13|~req[3]))begin NS=s2;count_n=0; end

            else if(req[3]&(~w03|~req[0])&(~w13|~req[1])&(~w23|~req[2]))begin NS=s4;count_n=0; end
                else begin NS=s0; end
    end
        
    
    s4:begin
    if(req[3]) begin
    g=4'b1000;
    if(count<2'b11) begin count_n=count+1'b1; NS=s4; end
    else begin count_n=1'b0;
    if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3])) NS = s1;
    else if(req[1]&(~w01_e|~req[0])&(w12_e|~req[2])&(w13_e|~req[3])) NS = s2;
    else if(req[2]&(~w02_e|~req[0])&(~w12_e|~req[1])&(w23_e|~req[3])) NS = s3;
    else if(req[3]&(~w03_e|~req[0])&(~w13_e|~req[1])&(~w23_e|~req[2])) NS = s4;
    else NS=s0;  
    end
    end
            else if(req[0]&(w01_e|~req[1])&(w02_e|~req[2])&(w03_e|~req[3]))begin NS=s1;count_n=0; end
        else if(req[1]&(~w01|~req[0])&(w12|~req[2])&(w13|~req[3]))begin NS=s2;count_n=0; end
        else if(req[2]&(~w02|~req[0])&(~w12|~req[1])&(w23|~req[3]))begin NS=s3;count_n=0; end
                else begin NS=s0;count_n=0; end
    end
        
    
    default: begin NS=s0;count_n=0;g=4'b0000; end
    
    endcase
    end
    end
    
    assign grant=g;
    
endmodule
