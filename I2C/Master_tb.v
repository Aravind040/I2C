module master_tb();
    reg clk;
    reg start;
    reg stop;
    reg [3:0] address;
    reg  [3:0] msg;    
    reg ack;
    wire sda;
    wire scl;
    reg reset;
    
    master uut(.clk(clk),.start(start),.stop(stop),.ack(ack),.sda(sda),.msg(msg),.address(address),.reset(reset),.scl(scl));      
    always #5 clk=~clk;
    initial begin
    clk=1'b0;
    reset=0;
    #30 reset=1;
    address<=4'b1100;
    msg<=4'b0101;
    start=1;
    #32start=0;
    #40 ack=1;
    #110 ack=0;
    #115 stop=1;
    #10;
    $finish;
    end
endmodule