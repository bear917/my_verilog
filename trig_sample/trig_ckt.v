`timescale 1ns / 1ps

module trig_ckt(
  input clk,
//  input trig_en,
  output trig
);
  
  reg trig_reg = 0;
  assign trig = trig_reg;
  
  parameter [1:0] IDLE = 2'b00;
  parameter [1:0] CNT = 2'b01;
  parameter [1:0] DONE = 2'b10;
  
  reg [1:0] state = IDLE;
  reg [1:0] next_state = IDLE;
  reg isDone = 0;
  reg [19:0] trig_cnt = 0;
  
  reg trig_en = 0 ;
  reg [30:0] en_cnt = 0;
  
  always@(posedge clk) begin
    if(en_cnt==10000000) begin
        trig_en <= 1;
        en_cnt <= 0;
    end else begin
        trig_en <= 0;
        en_cnt <= en_cnt + 1;
    end
  
  
  end
  
  
  
  always@(posedge clk) 
    state <= next_state;
  
  always@* begin
    case(state)
      IDLE: 
        if(trig_en)	next_state <= CNT;
      	else	next_state <= IDLE;
      CNT:
        if(isDone) next_state <= DONE;
      	else	next_state <= CNT;
      DONE:
        next_state <= IDLE;
      
      default:
        next_state <= IDLE;
    endcase
  end
  
  always@(posedge clk) begin
    if(state==CNT) begin
      if(trig_cnt==2000) begin
      	isDone <= 1;
      end else begin
      	trig_cnt <= trig_cnt + 1;
        trig_reg <= 1;
      end
    end else if(state==DONE) begin
    	isDone <=0;
    end else begin
    	trig_cnt <= 0;
      	trig_reg <= 0;
    end
  end
      
      
endmodule
