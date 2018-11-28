module probador #(
parameter ADDR_WIDTH = 3,
parameter BUS_SIZE = 5,
parameter MEM_LENGTH = 1 << ADDR_WIDTH)(

 output reg 		 clk,
 output reg 		 reset ,
 
 output reg [BUS_SIZE:0] data_p0,
 output reg 		 valid_p0,

 output reg [BUS_SIZE:0] data_p1,
 output reg 		 valid_p1,

 output reg [3:0] 	 umbralA,
 output reg [3:0] 	 umbralB,
 output reg 		 init,
 
 input [BUS_SIZE-1:0] 	 out_p1,
 input [BUS_SIZE-1:0] 	 out_p0,
					
 input 			 continue_VC0P0,
 input 			 continue_VC1P0,
 input 			 continue_VC0P1,
 input 			 continue_VC1P1, 
 
 input 			 pause_VC0P0,
 input 			 pause_VC1P0,
 input 			 pause_VC0P1,
 input 			 pause_VC1P1,
		   
 input [BUS_SIZE-1:0] 	 out_p1E,
 input [BUS_SIZE-1:0] 	 out_p0E,
					
 input 			 continue_VC0P0E,
 input 			 continue_VC1P0E,
 input 			 continue_VC0P1E,
 input 			 continue_VC1P1E, 
 
 input 			 pause_VC0P0E,
 input 			 pause_VC1P0E,
 input 			 pause_VC0P1E,
 input 			 pause_VC1P1E,

 input 			 active,
 input 			 idle,
 input 			 error,
 input [7:0] 		 umbrales_VCFC,
 
 input 			 activeE,
 input 			 idleE,
 input 			 errorE,
 input [7:0] 		 umbrales_VCFCE					
);
   
   
   // Probador
   initial begin
   $dumpfile("pcie.vcd");
	$dumpvars();
   @(posedge clk);
      init <=1;
      
   @(posedge clk);
      reset<=0;
        
   
   @(posedge clk); /// 1
      data_p0<=6'b011011; // C0 1B
      valid_p0<=1;
      
      data_p1<='b001101; // C0 0D
      valid_p1<=1;
      
      
   
   @(posedge clk); /// 2
      data_p0<='b000011; // C0 03
      valid_p0<=1;
      
      data_p1<='b010001;// C0 11
      valid_p1<=1;


     @(posedge clk);/// 3 
      data_p0<='b011010; // C0 1A
      valid_p0<=1;
      
      data_p1<='b001100;// C0 0C
      valid_p1<=1;

      
      @(posedge clk); //4 
      data_p0<='b001001; // C0 09
      valid_p0<=1;
      
      data_p1<='b011001;// C0 19
      valid_p1<=1;
      
      @(posedge clk); //5
      data_p0<='b011011; //C0 1B
      valid_p0<=1;
      
      data_p1<='b001101; // C0 0D
      valid_p1<=1;

      @(posedge clk); // 6
      data_p0<='b011111; //C0 1F
      valid_p0<=1;
      
      data_p1<='b001111; // C0 0F
      valid_p1<=1;

       @(posedge clk);

      data_p0<='b010111; //C0 17
      valid_p0<=1;
      
      data_p1<='b000111; // C0 07
      valid_p1<=1;

      /////////////////////////////////////////////////
      
      @(posedge clk); 
      data_p0<='b111001; // C1 19
      valid_p0<=0;
      
      data_p1<='b101101;// C1 0D
      valid_p1<=0;

      repeat(7)begin
      @(posedge clk); 
      end
      
      @(posedge clk);
      data_p0<='b101011; //C1 0B
      valid_p0<=1;
      
      data_p1<='b111101; //C1 1D
      valid_p1<=1;
      ////
      @(posedge clk);
      data_p0<='b101001; // C1 09
      valid_p0<=1;
      
      data_p1<='b110101; // C1 15
      valid_p1<=1;
      ////
       @(posedge clk);
      data_p0<='b110011;// C1 13
      valid_p0<=1;
      
      data_p1<='b100101;// C1 05
      valid_p1<=1;
      ///
      @(posedge clk);
      data_p0<='b111001;// C1 19
      valid_p0<=1;
      
      data_p1<='b101111;// C1 0F
      valid_p1<=1;
      ///
      @(posedge clk);
      data_p0<='b111111; // 1F
      valid_p0<=1;
      
      data_p1<='b100111; // C1 07
      valid_p1<=1;
      //////////////////////////////////////////////////////
      @(posedge clk);
      data_p0<='b110000; // 0
      valid_p0<=1;
      
      data_p1<='b100000; // 0
      valid_p1<=1;

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
   initial init <=0 ;
   
   
      
   always #1 clk <= ~clk;
   

endmodule 
