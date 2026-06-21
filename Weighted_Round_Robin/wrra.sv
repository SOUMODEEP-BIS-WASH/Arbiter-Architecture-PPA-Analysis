`timescale 1ns / 1ps


module wrra(
input clk, rst,
input [3:0]req,
output [3:0]grant
);

parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

//Internal Registers
reg [3:0]grant_reg;
reg [2:0]PS,NS; 
reg [2:0]count=3'b000,count_n=3'b000;

//SEQUENTIAL LOGIC
always @(posedge clk or posedge rst)
begin
if(rst) begin PS<=S0; count<=3'b000; end
else begin PS<=NS; count<=count_n; end
end

//COMBINATIONAL LOGIC
always @(*) begin
case(PS)
    S0:
    begin
    if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
    else if (req[1:0]==2'b10) begin NS=S2; count_n=3'b000; end
    else if (req[2:0]==3'b100) begin NS=S3; count_n=3'b000; end
    else if (req[3:0]==4'b1000) begin NS=S4; count_n=3'b000; end   
    else begin NS = S0; count_n =0; end
    end
    
    S1:
    begin
    if(req[0]==1'b1)
    begin
        if(count==3'b100) begin
                if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
                else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
                else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
                else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
                else begin NS = S0; count_n =0; end
        end
        else begin
        NS=S1;
        count_n=count+1'b1;
        end
    end
    else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
    else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
    else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
    else begin NS = S0; count_n =0; end
    end
    
    S2:
    begin
    if(req[1]==1'b1)
    begin
        if(count==3'b011) begin
                if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
                else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
                else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
                else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
                else begin NS = S0; count_n =0; end
        end
        else begin
        NS=S2;
        count_n=count+1'b1;
        end
    end
    else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
    else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
    else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
    else begin NS = S0; count_n =0; end
    end
    
    S3:
    begin
    if(req[2]==1'b1)
    begin
        if(count==3'b010) begin
                if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
                else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
                else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
                else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
                else begin NS = S0; count_n =0; end
        end
        else begin
        NS=S3;
        count_n=count+1'b1;
        end
    end
    else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
    else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
    else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
    else begin NS = S0; count_n =0; end
    end
    
    S4:
    begin
    if(req[3]==1'b1)
    begin
        if(count==3'b001) begin
                if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
                else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
                else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
                else if(req[3]==1'b1) begin NS=S4; count_n=3'b000; end
                else begin NS = S0; count_n =0; end
        end
        else begin
        NS=S4;
        count_n=count+1'b1;
        end
    end
    else if(req[0]==1'b1) begin NS=S1; count_n=3'b000; end
    else if(req[1]==1'b1) begin NS=S2; count_n=3'b000; end
    else if(req[2]==1'b1) begin NS=S3; count_n=3'b000; end
    else begin NS = S0; count_n =0; end
    end
    
    default: begin NS = S0; count_n =0; end
endcase
end

//OUTPUTS

always @(*) begin
    case(PS)
        S0: grant_reg=4'b0000;
        S1: grant_reg=4'b0001;
        S2: grant_reg=4'b0010;
        S3: grant_reg=4'b0100;
        S4: grant_reg=4'b1000;
        default: grant_reg=4'b0000;
    endcase
end

assign grant=grant_reg;

endmodule