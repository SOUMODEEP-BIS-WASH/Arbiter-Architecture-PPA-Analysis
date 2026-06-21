module arb2_1(
input clk,rst,
input req1,req2,
input en,
output g1,g2,
output requ
);

parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;

reg priority=1'b1, priority_n;
reg [1:0]NS,PS;
reg [1:0]count=2'b00,count_n=2'b00;
wire done;

assign done=(count==2'b11);

assign requ=req1|req2;

always @(posedge clk or posedge rst) begin
if(rst)begin PS<=s0; count<=2'b00; priority<=1'b1; end
else if(en) begin PS<=NS; count<=count_n; priority<=priority_n; 
if(done&&req1&&req2) priority<=~priority;
end
end

always @(*) begin
NS=PS;
count_n=count;
priority_n=priority;
case(PS)
    
    s0: begin
    count_n=2'b0; 
    if(req1 && ~req2) begin NS=s1; end
    else if(~req1 && req2) begin NS=s2; end
    else if(req1 && req2) begin 
    NS=(priority_n)?s1:s2;
    end
    else NS=s0;
    end 
    
    s1: begin
    if(req1&&req2) begin
        if(!done) begin count_n=count+1'b1; NS=s1; end
        else begin 
        count_n=2'b00;
        priority_n=~priority;
        NS=(priority_n)?s1:s2;  
        end
    end
    else if(req1) begin count_n=2'b0; NS=s1; end
    else if(req2) begin count_n=2'b0; NS=s2; end
    else NS=s0;
    end

    s2: begin
    if(req2&&req1) begin
        if(!done) begin count_n=count+1'b1; NS=s2; end
        else begin 
        count_n=2'b00;
        priority_n=~priority;
        NS=(priority_n)?s1:s2;
        end
    end
    else if(req1) begin count_n=2'b0; NS=s1; end
    else if(req2) begin count_n=2'b0; NS=s2; end
    else NS=s0;
    end
    
    default: NS=s0;
    
endcase
end

assign g1=en&&(PS==s1);
assign g2=en&&(PS==s2);

endmodule
