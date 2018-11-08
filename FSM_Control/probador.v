// módulo probador para el mux 2x1 automático
module probador (	input [7:0] umbrales_VCFC_condu,
			input 	   active_condu,
			input 	   idle_condu,
			input 	   error_condu, 
			input [7:0] umbrales_VCFC_estru,
			input 	   active_estru,
			input 	   idle_estru,
			input 	   error_estru, 
			output reg clk,
			output reg reset_L,
			output reg init,
			output reg [7:0] umbral_VCFC,
			output reg FIFO_error,
			output reg FIFO_empty);

   

	// Generador de señal de reloj
	initial clk <= 0;
	always #1 clk = ~clk;	

	initial 
	begin
		$dumpfile("fsmControl.vcd");	// Archivo de salida para 
     		$dumpvars(0,testbench); 	// GTKWave

		// secuencia de pruebas
	   reset_L <= 0;
	   init<=0;
	   umbral_VCFC<=8'b00000000;
	   FIFO_error<=0;
	   FIFO_empty <= 0;
 


	   @(posedge clk);
	   reset_L <= 1;
	   
	   @(posedge clk);
	   init <= 1;

	   
	   @(posedge clk);
	   FIFO_error <= 1;
	   init <= 0;

	   @(posedge clk);
	   reset_L <= 0;
	   FIFO_error <= 0;

	   #4 reset_L <= 1;
	
	   @(posedge clk);
	   init <= 1;
	   umbral_VCFC<=8'b10101111;
	   FIFO_empty <= 1;

	   @(posedge clk);
	   init <= 0;

	   #4 FIFO_empty <= 0;
  
	   
	   
	   #20 $finish;
	   
	end

endmodule
