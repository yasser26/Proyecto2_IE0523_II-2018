`include "memoria.v"
module fifo#(// Constantes
		parameter BUS_SIZE = 5,
		parameter ADDR_WIDTH = 3,
		parameter MEM_LENGTH = 1 << ADDR_WIDTH // 2^3= 8 TAMAÑO DEL BUFFER
		
	) (
	input 		      clk,
	input 		      reset, 
	input 		      pop,
	input 		      push,
	input 		      valid,
	input [BUS_SIZE-1:0]  data_in,

	output 		      pause,
	output 		      continua,
	output 		      empty,
	output reg		      valid_out,
	output [BUS_SIZE-1:0] data_out

);
   // Para la lógica de push y pop se debe saber que al realizar un pop se lee el dato de la memoria y en esa posición se escribe un 0 para indicar que se encuentra libre para ser utilizada cuando se realice un pop
   reg [ADDR_WIDTH-1:0]       wr_ptr;
   reg [MEM_LENGTH-1:0]       valid_bus; // bus del tamaño de la memoria
   wire[ADDR_WIDTH-1:0]  wr_add; // dirección de leer
   reg [ADDR_WIDTH-1:0] 	  rd_ptr; // dirección de escribir
   wire	[ADDR_WIDTH:0]			 filled;
   
   wire 				  almost_full , almost_empty,write_en;
   wire [BUS_SIZE-1:0] 			  to_fifo;

   
 			  
   
   
   memoria channel(/*AUTOINST*/
	       // Outputs
	       .data_out		(data_out),
	       // Inputs
	
	       .clk			(clk),
	       .reset                   (reset),
	       .read			(pop),
	       .write			(write_en), 
	       .data_in			(to_fifo),
	       .addressR		(rd_ptr),
	       .addressW		(wr_add));
   
   
   always@(posedge clk)begin
      if (reset)begin
	 rd_ptr<=0;
	 wr_ptr<=0;
      end
      else begin
	 rd_ptr<= pop ? (rd_ptr == 3'b111 ? 0 : rd_ptr+1 ): rd_ptr; // 
	 
	 wr_ptr<= push ? (wr_ptr == 3'b111 ? 0 : wr_ptr+1) : wr_ptr;
	 
	 if (push)  valid_bus[wr_ptr] <= valid;
	 if (pop)   valid_out <= valid_bus[rd_ptr];
	 
      end
   end // always@ (posedge clk)

   assign pause = almost_full ;
   assign continua = pause ? 0 : 1 ;
    
   assign filled = (rd_ptr > wr_ptr) ?	8-rd_ptr+wr_ptr : wr_ptr-rd_ptr;
   assign empty  = filled == 0 ? 1 :0 ;

   assign wr_add = pop ? rd_ptr : wr_ptr;
 
   assign almost_full = filled > 5 ? 1:0;

   assign almost_empty = filled < 3 ? 1:0; // 

   assign write_en = pop || push ? 1 : 0; // siempre que tenga un push o un pop escribo 

   assign to_fifo= push ? data_in : 'b0; // señal intermedia ya que siempre se escribe con push data_in y pop un cero para borrar el dato
   
  
   
   endmodule
   
