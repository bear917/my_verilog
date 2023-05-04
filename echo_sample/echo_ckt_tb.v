`timescale 1ns / 1ps

module echo_ckt_tb;
  reg clk;
  reg echo;
  
  wire echo_done;
  wire [19:0] du;
  
  echo_ckt UUT(
    clk,
    echo,
    echo_done,
    du
  );
  
	always 
      #5 clk = ~clk;
  
    initial begin
      	echo = 0;
      	#20 echo = 1;
      	#500 echo = 0;
    end
  
  
endmodule
