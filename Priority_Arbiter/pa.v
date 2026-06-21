`timescale 1ns/1ps

/*
CPU0 HIGHEST PRIORITY
CPU1 SECOND HIGHEST PRIORITY
CPU2 THIRD HIGHEST PRIORITY
CPU3 LOWEST PRIORITY
*/

module PA(
    input clk,rst,
    input [3:0]req,
    output reg [3:0]grant
);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100;

reg [2:0]PS,NS;

always @(posedge clk or posedge rst) begin
    if (rst) PS<=S0;
    else PS<=NS;
end
    
always @(PS,req) begin
NS=PS;
    case (PS)
        S0: begin
            if(req[0]==1'b1) NS = S1;
            else if(req[1:0]==2'b10) NS = S2;
            else if(req[2:0]==3'b100) NS = S3;
            else if(req[3:0]==4'b1000) NS = S4;
            else NS = S0;
        end
        S1: begin
            if(req[0]==1'b1) NS = S1;
            else NS = S0;
        end
        S2: begin
            if(req[1:0]==2'b10) NS = S2;
            else NS = S0;
        end
        S3: begin
            if(req[2:0]==3'b100) NS = S3;
            else NS = S0;
        end
        S4: begin
            if(req[3:0]==4'b1000) NS = S4;
            else NS = S0;
        end
        default: NS = S0;
    endcase
end

always @(PS, req) begin
    case (PS)
        S0:grant=4'b0000;
        S1:grant=4'b0001;
        S2:grant=4'b0010;
        S3:grant=4'b0100;
        S4:grant=4'b1000;
        default: grant=4'b0000;
    endcase
end

endmodule