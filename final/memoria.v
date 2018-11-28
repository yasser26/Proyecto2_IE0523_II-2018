module memoria#(
	// Constantes
		parameter BUS_SIZE = 5,
		parameter ADDR_WIDTH = 3,
		parameter MEM_LENGTH = 1 << ADDR_WIDTH // 2^3= 8 TAMAÑO DEL BUFFER
		
	) (
	input 			  clk,
	input 			  read,
	input 			  reset,
	input 			  write,
	input [BUS_SIZE-1:0] 	  data_in,
	input [ADDR_WIDTH-1:0] 	  addressR, // dirección de leer
	input [ADDR_WIDTH-1:0] 	  addressW, // dirección de escribir
	output reg [BUS_SIZE-1:0] data_out
);


reg [BUS_SIZE-1:0] mem [MEM_LENGTH-1:0]; // creación de la memoria

always @ (posedge clk) begin
	if(reset)
	    data_out <= 0;
	else begin
  		if (write)  mem[addressW] <= data_in;
  		if (read) data_out <= mem[addressR];
	end
	   
end

endmodule
