`timescale 1ns/1ps

/*
CPU0 HIGHEST PRIORITY
CPU1 SECOND HIGHEST PRIORITY
CPU2 THIRD HIGHEST PRIORITY
CPU3 LOWEST PRIORITY
EACH CPU WILL ONLY GET 3 COUNTS OF USE
*/

module RRA(
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
reg [1:0]count=2'b00;
reg [1:0]count_next=2'b00;

always @(posedge clk or posedge rst) begin
    if (rst) begin PS<=S0; count<=2'b00; end 
    else begin PS<=NS; count<=count_next; end
end
    
always @(*) begin
    NS = PS;               
    count_next = count;
    
    case (PS)
        S0: begin
            if(req[0]==1'b1) begin NS = S1; count_next =0; end
            else if(req[1]==1'b1) begin NS = S2; count_next =0; end
            else if(req[2]==1'b1) begin NS = S3; count_next =0; end
            else if(req[3]==1'b1) begin NS = S4; count_next =0; end
            else begin NS = S0; count_next =0; end
        end
        S1: begin
            if(req[0]==1'b1) 
            begin 
                if(count==2'b11) begin
                    if(req[1]==1'b1) begin NS=S2; count_next=0; end
                    else if(req[2]==1'b1) begin NS=S3; count_next=0; end
                    else if(req[3]==1'b1) begin NS=S4; count_next=0; end
                    else if(req[0]==1'b1) begin NS=S1; count_next=0; end
                    else begin NS = S0; count_next =0; end
                end 
                else begin
                    NS = S1;
                    count_next = count + 1'b1;
                end
            end
            else if(req[1]==1'b1) begin NS=S2; count_next=0;end
            else if(req[2]==1'b1) begin NS=S3; count_next=0;end
            else if(req[3]==1'b1) begin NS=S4; count_next=0;end
            else begin NS = S0; count_next =0; end
        end
        S2: begin
            if(req[1]==1'b1) 
            begin 
                if(count==2'b11) begin
                    if(req[2]==1'b1) begin NS=S3; count_next=0; end
                    else if(req[3]==1'b1) begin NS=S4; count_next=0; end
                    else if(req[0]==1'b1) begin NS=S1; count_next=0; end
                    else if(req[1]==1'b1) begin NS=S2; count_next=0; end
                    else begin NS = S0; count_next =0; end
                end 
                else begin
                    NS = S2;
                    count_next = count + 1'b1;
                end
            end
            else if(req[0]==1'b1) begin NS=S1; count_next=0;end
            else if(req[2]==1'b1) begin NS=S3; count_next=0;end
            else if(req[3]==1'b1) begin NS=S4; count_next=0;end
            else begin NS = S0; count_next =0; end
        end

        S3: begin
            if(req[2]==1'b1) 
            begin 
                if(count==2'b11) begin
                    if(req[3]==1'b1) begin NS=S4; count_next=0; end
                    else if(req[0]==1'b1) begin NS=S1; count_next=0; end
                    else if(req[1]==1'b1) begin NS=S2; count_next=0; end
                    else if(req[2]==1'b1) begin NS=S3; count_next=0; end
                    else begin NS = S0; count_next =0; end
                end 
                else begin
                    NS = S3;
                    count_next = count+1'b1;
                end
            end
            else if(req[0]==1'b1) begin NS=S1; count_next=0;end
            else if(req[1]==1'b1) begin NS=S2; count_next=0;end
            else if(req[3]==1'b1) begin NS=S4; count_next=0;end
            else begin NS = S0; count_next =0; end
        end

        S4: begin
            if(req[3]==1'b1) 
            begin 
                if(count==2'b11) begin
                    if(req[0]==1'b1) begin NS=S1; count_next=0; end
                    else if(req[1]==1'b1) begin NS=S2; count_next=0; end
                    else if(req[2]==1'b1) begin NS=S3; count_next=0; end
                    else if(req[3]==1'b1) begin NS=S4; count_next=0; end
                    else begin NS = S0; count_next =0; end
                end 
                else begin
                    NS = S4;
                    count_next = count+1'b1;
                end
            end
            else if(req[0]==1'b1) begin NS=S1; count_next=0;end
            else if(req[1]==1'b1) begin NS=S2; count_next=0;end
            else if(req[2]==1'b1) begin NS=S3; count_next=0;end
            else begin NS = S0; count_next =0; end
        end

        default: begin NS = S0; count_next =0; end
    endcase
end

always @(*) begin
    case (PS)
        S0:grant=4'b0000;
        S1: grant =  4'b0001;
        S2: grant =  4'b0010;
        S3: grant =  4'b0100;
        S4: grant =  4'b1000;
        default: grant=4'b0000;
    endcase
end

endmodule