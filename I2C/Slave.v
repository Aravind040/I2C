module slave(
input wire sda,
output wire scl,
input reset,
input [3:0] msg,
output reg enable,
output reg ack,
input clk
);
reg [3:0] state1=0;
reg [3:0] count;
reg  [3:0] address=4'b1100;
assign scl= (reset) ?  clk : 1'bz;
reg temp;
reg a;
reg out;
always @(negedge clk)begin 
case(state1) 
0:begin 
if(reset) begin 
ack<=0;
temp<=0;
a<=0;
enable<=1;
state1<=1;
count<=4;
end
else state1<=0;
end 
1: begin 
if(sda==0) state1<=2;
else state1<=1;
end 
2: begin 
if(count==0) begin 
state1<=3;
enable<=0;
a<=1;
end 
else begin 
if(sda==address[count-1]) begin 
count=count-1;
state1<=2;
end 
else begin 
count=count-1;
state1<=2;
temp<=1;
end
end 
end 
3:begin 
if(temp==0)begin 
ack<=1;
a<=0;
state1<=4;
end
else begin
ack<=0;
a<=0;
state1<=2;
end 
end
4: begin 
if(sda) begin 
state1<=5; 
count<=4;
enable<=0;
end 
else begin
state1<=6;
enable<=1;
end 
end
5: begin
if(count==0) begin
state1<=0;
end
else begin 
ack<=msg[count-1];
count=count-1;
state1<=5;
end 
end
6: begin 
enable<=1;
a<=0;
out<=sda;
state1<=0;
end 
endcase 
end 
endmodule