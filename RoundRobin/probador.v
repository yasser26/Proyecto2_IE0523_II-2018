// módulo probador para el mux 2x1 automático
module probador (	input portMux_condu,
									input validMux_condu,
									input pop0_condu,
									input pop1_condu,
									input portMux_estru,
									input validMux_estru,
									input pop0_estru,
									input pop1_estru,
									output reg clk,
									output reg reset_L,
									output reg request0,
									output reg request1);



	// Generador de señal de reloj
	initial clk <= 0;
	always #1 clk = ~clk;

	initial
	begin
		$dumpfile("round_robin.vcd");	// Archivo de salida para
     		$dumpvars(0,testbench); 	// GTKWave

		// secuencia de pruebas
	   reset_L <= 0;
		 request0 <= 0;
		 request1 <= 0;

	   @(posedge clk);
	   reset_L <= 1;

	   #20 @(posedge clk);
		 request0 <= 0;
		 request1 <= 1;

		 #20 @(posedge clk);
		 request0 <= 1;
		 request1 <= 1;

		 #20 @(posedge clk);
		 request0 <= 1;
		 request1 <= 0;

		 #20 @(posedge clk);
		 reset_L <= 0;

	   #20 $finish;

	end

endmodule
