`timescale 1ns / 1ps

module trig_ckt_tb;
  reg clk;
  reg trig_en;
  
  wire trig;
  
  trig_ckt t1(
    clk,
    trig_en,
    trig
  );
  
  
  initial
  	clk = 0;
  
  always
    #5 clk = ~clk;
  
  initial begin
  	trig_en = 0;
    #8 trig_en = 1;
    #20 trig_en = 0;
    #100000 trig_en = 1;
    #20 trig_en = 0;
  
  end
  
endmodule
