module slave_tb();
reg clk;
wire sda;
reg sda_in;
reg reset;
slave uut(.clk(clk),.sda(sda),.sda_in(sda_in),.reset(reset));
always #5 clk=~clk;
initial begin 
clk=1'b0;
#10 reset=1'b0;
reset=1'b1;
sda_in=1'b1;
#10sda_in=1'b0;
#10sda_in=1'b1;
#10 sda_in=1'b1;
#10 sda_in=1'b0;
#10 sda_in=1'b0;
//#10 sda_in=1'b1;
//#10 sda_in=1'b0;
//#10 sda_in=1'b0;
#30;
#10 sda_in=1'b0;
#10 sda_in=1'b1;
#10 sda_in=1'b1;
#10 sda_in=1'b1;
#10 sda_in=1'b0;
#10 sda_in=1'b1;
#10 sda_in=1'b0;
#10 sda_in=1'b1;
end 
endmodule