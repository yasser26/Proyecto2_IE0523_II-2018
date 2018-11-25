module probador #(
parameter ADDR_WIDTH = 3,
parameter BUS_SIZE = 5,
parameter MEM_LENGTH = 1 << ADDR_WIDTH)(

 output reg 		   clk,
 output reg 		   reset ,
 
 output reg [BUS_SIZE:0] data_p0,
 output reg 		   valid_p0,

 output reg [BUS_SIZE:0] data_p1,
 output reg 		   valid_p1,

 output reg [3:0] 	   umbralA,
 output reg [3:0] 	   umbralB, 
 
 input [BUS_SIZE-1:0] 	   out_p1,
 input [BUS_SIZE-1:0] 	   out_p0,
					
 input 			   continue_VC0P0,
 input 			   continue_VC1P0,
 input 			   continue_VC0P1,
 input 			   continue_VC1P1, 
 
 input 			   pause_VC0P0,
 input 			   pause_VC1P0,
 input 			   pause_VC0P1,
 input 			   pause_VC1P1		   

);
   
   
   // Probador
   initial begin
   $dumpfile("pcie.vcd");
	$dumpvars();

   #2 @(posedge clk);
      reset<=0;
   
   
   @(posedge clk);
      data_p0<=6'b011011;
      valid_p0<=1;
      
      data_p1<='b001101;
      valid_p1<=1;
      
      
   
   @(posedge clk); 
      data_p0<='b000011;
      valid_p0<=1;
      
      data_p1<='b010001;
      valid_p1<=1;


     @(posedge clk); 
      data_p0<='b011010;
      valid_p0<=1;
      
      data_p1<='b001100;
      valid_p1<=1;

      
      @(posedge clk); 
      data_p0<='b001001;
      valid_p0<=1;
      
      data_p1<='b011001;
      valid_p1<=1;
      
      @(posedge clk); 
      data_p0<='b011011;
      valid_p0<=1;
      
      data_p1<='b001101;
      valid_p1<=1;

      @(posedge clk); 
      data_p0<='b011111;
      valid_p0<=1;
      
      data_p1<='b001111;
      valid_p1<=1;

      @(posedge clk);
      data_p0<=6'b011011;
      valid_p0<=1;
      
      data_p1<='b001101;
      valid_p1<=1;
      
   
      ////////////////////////////////////////// Almost_full p0 y p1 en vc0
      @(posedge clk); 
      data_p0<='b111001;
      valid_p0<=1;
      
      data_p1<='b101101;
      valid_p1<=1;
      //////
      @(posedge clk);
      data_p0<='b101011;
      valid_p0<=1;
      
      data_p1<='b111101;
      valid_p1<=1;
      ////
      @(posedge clk);
      data_p0<='b101011;
      valid_p0<=1;
      
      data_p1<='b111101;
      valid_p1<=1;
      ////
       @(posedge clk);
      data_p0<='b110011;
      valid_p0<=1;
      
      data_p1<='b100101;
      valid_p1<=1;
      ///
      @(posedge clk);
      data_p0<='b111001;
      valid_p0<=1;
      
      data_p1<='b101111;
      valid_p1<=1;
      ///
      @(posedge clk);
      data_p0<='b111111;
      valid_p0<=1;
      
      data_p1<='b101111;
      valid_p1<=1;
      ///


      #100
   $finish;
end  
   
   initial clk <= 0;
   initial reset<=1;
   initial valid_p0<=0;
   initial valid_p1<=0;
   initial data_p0<=0;
   initial data_p1<=0;
   initial umbralA<=4'd6;
   initial umbralB<=4'd3;
   
      
   always #1 clk <= ~clk;
   

endmodule 
