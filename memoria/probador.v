module probador #(
parameter ADDR_WIDTH = 4,
parameter BUS_SIZE = 4,
// No modificar estos parametros
parameter MEM_LENGTH = 1 << ADDR_WIDTH)(

// Existen algunas directivas de compilacion o macros,
// Por ejemplo, `define, `ifdef, `ifndef, `endif;
// no funcionan bien en algunas versiones de icarus.
// Los  defines, se trabajan en un archivo individual
// Son globales, al definirlos una vez,
// se definen en todo el ambiente o workspace
// Los valores de los defines se eligen por los
// arquitectos del chip y se utilizan en los bloques
// de mayor jerarquia o top-level-blocks, para asiganar
// valor como tamanos de buses. En este caso, ADDR_WIDTH
// y BUS_SIZE podrian ser defines numericos.
 output reg 		     clk,
 output reg 		     read,write,
 output reg [BUS_SIZE-1:0]   data_in,
 output reg [ADDR_WIDTH-1:0] addressR,
 output reg [ADDR_WIDTH-1:0] addressW,
 input wire [BUS_SIZE-1:0]   data_out_synth,
 input wire [BUS_SIZE-1:0]   data_out_cond);
   
   
   // Probador
   initial begin
   $dumpfile("dump.vcd");
	$dumpvars();
   @(posedge clk);
   read <= 0;
   write <= 0;
   data_in <= 0;
   addressR <= 0;
	addressW <= 0;
   @(posedge clk);
   repeat (MEM_LENGTH) begin
	   data_in <= $random;
	   write <= 1;
	   read <=1;
	   @(posedge clk);	
	   addressW <= addressW + 1;
	   addressR <= addressR + 1;
	end
   
   addressR <= 0;
   @(posedge clk);
   @(posedge clk);
   addressW <= -1;
   repeat (MEM_LENGTH) begin
	   read <= 1;
	   data_in<=$random;
	   @(posedge clk);
	   addressR <= addressR + 1;
	   addressW <= addressW + 1;
	   
	end
   //read <= 0;
   write <= 0;
   repeat (MEM_LENGTH) begin
      read <= 1;
      //data_in<=$random;
      @(posedge clk);
      addressR <= addressR + 1;
      //addressW <= addressW + 1;
      
   end
   @(posedge clk);@(posedge clk);
   $finish;
end  
   
   initial clk <= 0;
   always #1 clk <= ~clk;
   

endmodule 
