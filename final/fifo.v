`include "memoria.v"
module FIFO_mod#(// Constantes
		parameter BUS_SIZE = 5,
		parameter ADDR_WIDTH = 3,
		parameter MEM_LENGTH = 1 << ADDR_WIDTH // 2^3= 8 TAMAÑO DEL BUFFER
		
	) (
	input 			    clk,
	input 			    reset, 
	input 			    pop,
	input 			    push,
	input 			    valid,
	input [BUS_SIZE-1:0] 	    data_in,
	input [3:0] 		    umbralA,
	input [3:0] 		    umbralB,

	output 			    pause,
	output 			    continua,
	output 			    empty,
	output 			    fifo_error,
	output 			    almost_full , 
	output 			    almost_empty,
	output [BUS_SIZE-1:0] 	    data_out,
	output [ADDR_WIDTH:0]   filled,
	output reg [ADDR_WIDTH-1:0] rd_ptr, // dirección de escribir
	output reg [ADDR_WIDTH-1:0] wr_ptr,
	output reg 		    valid_out
);
   // Para la lógica de push y pop se debe saber que al realizar un pop se lee el dato de la memoria y en esa posición se escribe un 0 para indicar que se encuentra libre para ser utilizada cuando se realice un pop
  
   reg [MEM_LENGTH-1:0]       valid_bus; // bus del tamaño de la memoria
  
      
   
   wire [BUS_SIZE-1:0] 			  to_fifo;

   
   
   
   memoria channel(/*AUTOINST*/
	       // Outputs
	       .data_out		(data_out),
	       // Inputs
	
	       .clk			(clk),
	       .read			(pop),
	       .write			(push), 
	       .data_in			(to_fifo),
	       .addressR		(rd_ptr),
	       .addressW		(wr_ptr));
   
   
   always@(posedge clk)begin
      if (reset)begin
	 rd_ptr<=0;
	 wr_ptr<=0;
	// filled <=0;
	 
      end
      else begin
	 rd_ptr<= pop ? (rd_ptr == 3'b111 ? 0 : rd_ptr+1 ): rd_ptr ; // 
	 
	 wr_ptr<= push ? (wr_ptr == 3'b111 ? 0 : wr_ptr+1) : wr_ptr;
	// filled <= push ? filled+1: pop ? filled-1 : filled;
	 
	 if (push)  valid_bus[wr_ptr] <= valid;
	 if (pop)   valid_out <= valid_bus[rd_ptr];
	 
      end
   end // always@ (posedge clk)

 /*  always@(*)begin
      if(reset)
	filled=0;
      else
	filled = push ? filled+1: pop ? filled-1 : filled;
      
      end*/

   assign fifo_error = push && filled == 7 ? 1 : 0;
   
   assign pause = almost_full ;
   assign continua = almost_empty ;
    
   assign filled = (rd_ptr > wr_ptr) ?	8-rd_ptr+wr_ptr : wr_ptr-rd_ptr;
   assign empty  = filled == 0 ? 1 :0 ;

   assign almost_full = filled > umbralA-1 ? 1:0;

   assign almost_empty = filled < umbralB ? 1:0; // 

   assign to_fifo= push ? data_in : 'b0; // señal intermedia ya que siempre se escribe con push data_in y pop un cero para borrar el dato
   
  
   
   endmodule
   
