`timescale 1ns / 1ps

module echo_ckt(
  input clk,
  input echo,
  output echo_done,
  output [19:0] du
);
  
  reg [19:0] du_reg = 0;
  assign du = du_reg;
  
  reg echo_done_reg = 0;
  assign echo_done = echo_done_reg;
  
  reg [19:0] cnt = 0;
    
  parameter [1:0] IDLE = 2'b00;
  parameter [1:0] ECHO = 2'b01;
  parameter [1:0] DONE = 2'b10;
  
  reg [1:0] state = IDLE;
  reg [1:0] next_state = IDLE;  
    
  always@(posedge clk) begin
  	state <= next_state;
  end
  
   always@* begin
     case(state)
       IDLE: 
       		if(echo) next_state <= ECHO;
       	 	else	next_state <= IDLE;
       ECHO:
         if(echo) next_state <= ECHO;
       		else 	next_state <= DONE;
       DONE:
         	next_state <= IDLE;
       
       default:
         	next_state <= IDLE;
     endcase
   end
       
   always@(posedge clk) begin
     if (state==ECHO) begin
     	cnt <= cnt + 1;
     end else if(state==DONE) begin
     	du_reg <= cnt;
        echo_done_reg <= 1;
     end else begin
     	cnt <= 0;
        du_reg <= 0;
        echo_done_reg <= 0;
     end
   end
       
       
endmodule
