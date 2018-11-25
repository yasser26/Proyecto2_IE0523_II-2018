module memoria#(
	// Constantes
	parameter BUS_SIZE = 4,
	parameter ADDR_WIDTH = 4,
	parameter NUM_MEM_UNITS = 4,
	parameter MEM_LENGTH = 1 << ADDR_WIDTH,
	parameter MEM_UNIT_WIDTH = BUS_SIZE / NUM_MEM_UNITS
	) (
	input clk,
	input read,
	input write,
	input [BUS_SIZE-1:0] data_in,
	input [ADDR_WIDTH-1:0] addressR, // dirección de leer
	input [ADDR_WIDTH-1:0] addressW, // dirección de escribir
	output reg [BUS_SIZE-1:0] data_out
);


reg [BUS_SIZE-1:0] mem [MEM_LENGTH-1:0]; // creación de la memoria

always @ (posedge clk) begin
  	if (write)  mem[addressW] <= data_in;
  	if (read) data_out <= mem[addressR];
	   
end

endmodule
