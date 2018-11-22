`include"fifo.v"
`include"fsmControl.v"
`include"arbitro.v"

module PCIE_trans (input clk , input reset, input valid_p0 , input valid_p1 ,input [5:0] data_p0, input [5:0] data_p1,input [3:0] umbralA, input[3:0] umbralB, output[4:0] out_p0, output[4:0] out_p1,output pause_VC0P0,
   output 	pause_VC1P0, output pause_VC0P1, output pause_VC1P1, output	continue_VC0P0, output 	continue_VC1P0, output 	continue_VC0P1, output 	continue_VC1P1);
   
   wire [4:0]	ofifo_VC0P0;
   wire [4:0]	ofifo_VC1P0;
   wire [4:0]	ofifo_VC0P1;
   wire [4:0]	ofifo_VC1P1;
   
   wire 	oValid_VC0P0;
   wire 	oValid_VC1P0;
   wire 	oValid_VC0P1;
   wire 	oValid_VC1P1;
   
   reg valid_VC0P0;
   reg valid_VC1P0;
   reg valid_VC0P1;
   reg valid_VC1P1;
   
   wire 	empty_VC0P0;
   wire 	empty_VC1P0;	
   wire 	empty_VC0P1;
   wire 	empty_VC1P1;								
   
   wire 	fifoerr_VC0P0;
   wire 	fifoerr_VC1P0;	
   wire 	fifoerr_VC0P1;
   wire 	fifoerr_VC1P1;
      
   reg 	push_VC0P0;
   reg 	push_VC1P0;	
   reg 	push_VC0P1;
   reg 	push_VC1P1;
   
   wire 	pop_VC0P0;
   wire 	pop_VC1P0;	
   wire 	pop_VC0P1;
   wire 	pop_VC1P1;

   reg [4:0] 	data_VC0P0;
   reg [4:0] 	data_VC1P0;
   reg [4:0]	data_VC0P1;
   reg [4:0]	data_VC1P1;
   
  
   
   wire [7:0] 	umbrales_VCFC;		// From fsm of fsmControl.v

   always @(posedge clk) begin
      data_VC0P0 <=data_p0[5] ? 0 : data_p0[4:0] ;
      push_VC0P0 <=data_p0[5] ? 0 : 1 ;
      
      data_VC1P0<= data_p0[5] ? data_p0[4:0] : 0  ;
      push_VC1P0 <=data_p0[5]? 1 : 0 ;

      data_VC0P1 <=data_p1[5] ? 0 : data_p1[4:0] ;
      push_VC0P1 <=data_p1[5] ? 0 : 1 ;
      
      data_VC1P1<= data_p1[5] ? data_p1[4:0] : 0  ;
      push_VC1P1 <=data_p1[5]? 1 : 0 ;

      valid_VC0P0<=data_p0[5]? 0 : valid_p0;
      valid_VC0P1<=data_p0[5]? valid_p0 : 0 ;		   
      valid_VC1P0<=data_p1[5] ? 0 : valid_p1;
      valid_VC1P1<=data_p1[5] ? valid_p1 : 0;

		if (reset) begin
		   data_VC0P0 <= 0;
		   push_VC0P0 <=0;
      
		   data_VC1P0 <= 0;
		   push_VC1P0 <=0;
		   
		   data_VC0P1 <= 0;
		   push_VC0P1 <=0;
      
		   data_VC1P1<=  0;
		   push_VC1P1 <=0;

		   valid_VC0P0<=0;
		   valid_VC1P0<=0;
		   valid_VC0P1<=0;
		   valid_VC1P1<=0;
		   
		end
   end // always @ (posedge clk)

   arbitro arbitro1(/*AUTOINST*/
		    // Outputs
		    .popVC0_0		(pop_VC0P0),
		    .popVC1_0		(pop_VC1P0),
		    .popVC0_1		(pop_VC0P1),
		    .popVC1_1		(pop_VC1P1),
		    .dataOut_0		(out_p0[4:0]),
		    .dataOut_1		(out_p1[4:0]),
		    // Inputs
		    .clk		(clk),
		    .reset_L		(reset_L),
		    .VC0_p0		(ofifo_VC0P0),
		    .VC1_p0		(ofifo_VC1P0),
		    .VC0_p1		(ofifo_VC0P1),
		    .VC1_p1		(ofifo_VC1P1),
		    .validBits		({oValid_VC0P0,oValid_VC1P0,oValid_VC0P1,oValid_VC1P1}),
		    .emptyVC0_p0	(empty_VC0P0),
		    .emptyVC1_p0	(empty_VC1P0),
		    .emptyVC0_p1	(empty_VC0P1),
		    .emptyVC1_p1	(empty_VC1P1));
  
   
   
   // End of automatics
   FIFO_mod fifo_VC0P0 (
		    // Outputs
		    .pause		(pause_VC0P0),
		    .continua		(continue_VC0P0),
		    .empty		(empty_VC0P0),
		    .fifo_error		(fifoerr_VC0P0),
		    .valid_out		(oValid_VC0P0),
		    .data_out		(ofifo_VC0P0),
		    // Inputs
		    .clk		(clk),
		    .reset		(reset),
		    .pop		(pop_VC0P0),
		    .push		(push_VC0P0),
		    .valid		(valid_VC0P0),
		    .data_in		(data_VC0P0),
		    .umbralA		(umbralA),
		    .umbralB		(umbralB));
   FIFO_mod fifo_VC1P0 ( 
		    // Outputs
		     .pause		(pause_V1CP0),
		    .continua		(continue_VC1P0),
		    .empty		(empty_VC1P0),
		    .fifo_error		(fifoerr_VC1P0),
		    .valid_out		(oValid_VC1P0),
		    .data_out		(ofifo_VC1P0),
		    // Inputs
		    .clk		(clk),
		    .reset		(reset),
		    .pop		(pop_VC1P0),
		    .push		(push_VC1P0),
		    .valid		(valid_VC1P0),
		    .data_in		(data_VC1P0),
		    .umbralA		(umbralA),
		    .umbralB		(umbralB));
   FIFO_mod fifo_VC0P1 (
		    // Outputs
		    .pause		(pause_VC0P1),
		    .continua		(continue_VC0P1),
		    .empty		(empty_VC0P1),
		    .fifo_error		(fifoerr_VC0P1),
		    .valid_out		(oValid_VC0P1),
		    .data_out		(ofifo_VC0P1),
		    // Inputs
		    .clk		(clk),
		    .reset		(reset),
		    .pop		(pop_VC0P1),
		    .push		(push_VC0P1),
		    .valid		(valid_VC0P1),
		    .data_in		(data_VC0P1),
		    .umbralA		(umbralA),
		    .umbralB		(umbralB));
   FIFO_mod fifo_VC1P1 (
		    // Outputs
		     .pause		(pause_V1CP1),
		    .continua		(continue_VC1P1),
		    .empty		(empty_VC1P1),
		    .fifo_error		(fifoerr_VC1P1),
		    .valid_out		(oValid_VC1P1),
		    .data_out		(ofifo_VC1P1),
		    // Inputs
		    .clk		(clk),
		    .reset		(reset),
		    .pop		(pop_VC1P1),
		    .push		(push_VC1P1),
		    .valid		(valid_VC1P1),
		    .data_in		(data_VC1P1),
		    .umbralA		(umbralA),
		    .umbralB		(umbralB));

   fsmControl fsm(
		  // Outputs
		  .umbrales_VCFC	(umbrales_VCFC),
		  .active		(active),
		  .idle			(idle),
		  .error		(error),
		  // Inputs
		  .clk			(clk),
		  .reset_L		(reset_L),
		  .init			(init),
		  .umbral_VCFC		({umbralA,umbralB}),
		  .FIFO_error		(FIFO_error),
		  .FIFO_empty		(FIFO_empty));
   
   
   
   endmodule
