module probador #(
parameter ADDR_WIDTH = 3,
parameter BUS_SIZE = 5,
parameter MEM_LENGTH = 1 << ADDR_WIDTH)(

 output reg 		   clk,
 output reg 		   reset ,
 output reg 		   push,pop,
 output reg [BUS_SIZE-1:0] data_in,
 output reg 		   valid, 
 
 input [BUS_SIZE-1:0] 	   data_out_synth,
 input [BUS_SIZE-1:0] 	   data_out_cond,
 input 			   empty,
 input 			   continua,
 input 			   pause,
 input 			   valid_out,
 
input 			   empty_syn,
 input 			   continua_syn,
 input 			   pause_syn,
 input 			   valid_out_syn				

);
   
   
   // Probador
   initial begin
   $dumpfile("fifo.vcd");
	$dumpvars();
   @(posedge clk);
      reset<=0;
   
   
   @(posedge clk);
      data_in<='b1;
      push <= 1;
      valid <= ~valid; // 1
      
   
   @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid; // 2

     @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid; //3

      @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid;//4
       
      @(posedge clk); 
      push <= 1;     // 5 	 
      data_in <= $random;
      valid <= ~valid;
      
      @(posedge clk);
      push <=0;
      pop<= 0;
       ///////////////////////////////////////////////////////////
      @(posedge clk);
      data_in<=$random;
      valid <= ~valid;
      pop <= 1; // 1
      
       @(posedge clk);
      data_in<=$random;
      valid <= ~valid;
      pop <= 1; // 2

       @(posedge clk);
      data_in<=$random;
      valid <= ~valid;
      pop <= 1; // 3
      
    @(posedge clk);
      data_in<=$random;
      valid <= ~valid;
      pop <= 1; // 4

       @(posedge clk);
      data_in<=$random;
      valid <= ~valid;
      pop <= 1; // 5
   
   
   @(posedge clk);
      pop<=0;
///////////////////////////////////////////////////

      @(posedge clk);
      data_in<='b1;
      push <= 1;
      valid <= ~valid; // 1
      
   
   @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid; // 2

     @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid; //3

      @(posedge clk); 
      push <= 1;	
      data_in <= $random;
      valid <= ~valid;//4
       
      @(posedge clk); 
      push <= 1;     // 5 	 
      data_in <= $random;
      valid <= ~valid;

      @(posedge clk); 
      push <= 1;     // 6 	 
      data_in <= $random;
      valid <= ~valid;

      @(posedge clk); 
      push <= 1;     // 7	 
      data_in <= $random;
      valid <= ~valid;

      @(posedge clk);
      push <=0;
      
      
      #1000
   $finish;
end  
   
   initial clk <= 0;
   initial reset<=1;
   initial valid<=0;
   //initial data_in<=0;
   initial pop<=0;
   initial push<=0;
   
   
   always #1 clk <= ~clk;
   

endmodule 
