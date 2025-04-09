module master(
    output wire sda,
    output wire scl,
    output reg enable,
    input reset,
    input clk,
    input start,
    input [3:0] address,
    input rw,
    input stop,
    input ack,
    input [3:0] msg
    );
    reg [3:0] state;
    reg sdao;
    //wire temp;
    reg [3:0] count;
    reg temp1;
    reg out;
    assign scl= (!reset) ? 0 :((start==0 && temp1) ? clk : 1'b0);
    //assign temp=sdao;
    assign sda=sdao;
    
    always @(posedge clk )begin 
   case(state)
   0: begin 
   if(reset)
   begin
    state<=1;
    temp1<=0;
    sdao<=1;
    enable<=0;
    count<=5;
    end
   else if(clk)
    state<=0;
   end 
   1: begin 
   if (start==0) begin
        count<=4;
        sdao<=0;
        state<=2;
        temp1<=1;
   end
   else state<=1;
   end 
   2: begin 
   if(count==0)begin 
   state<=3;
   enable<=1;
   end 
   else begin 
   sdao<=address[count-1];
   count<=count-1;
   state<=2;
   end 
   end 
   3: begin 
   if (ack) begin 
   state<=4;
   end 
   else begin 
   state<=3;
   end
   end 
   4: begin
   if(rw==0) begin 
   count<=4;
   enable<=0;
   sdao<=0;
   state<=5;
   end 
   else begin 
   state<=6;
   sdao<=1;
   enable<=1;
   end 
   end 
   5: begin 
   if(count==0) begin 
   state<=7;
   sdao<=0;
   end
   else begin 
   sdao<=msg[count-1];
   count<=count-1;
   end
   end 
   6: begin 
   out<=ack;
   state<=7;
   end  
   7: begin 
   if(stop) begin 
   sdao<=0;
   state<=0;
   end 
   end 
   default: state<=0;
   endcase 
   end