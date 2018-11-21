// módulo probador para el mux 2x1 automático
module probador (	input popVC0_0_condu,
									input popVC1_0_condu,
									input popVC0_1_condu,
									input popVC1_1_condu,
									input [4:0] dataOut0_condu,
									input [4:0] dataOut1_condu,
									input popVC0_0_estru,
									input popVC1_0_estru,
									input popVC0_1_estru,
									input popVC1_1_estru,
									input [4:0] dataOut0_estru,
									input [4:0] dataOut1_estru,
									output reg clk,
									output reg reset_L,
									output reg [4:0] VC0_p0,
									output reg [4:0] VC1_p0,
									output reg [4:0] VC0_p1,
									output reg [4:0] VC1_p1,
									output reg [3:0] validBits,
                  output reg emptyVC0_p0,
                  output reg emptyVC1_p0,
                  output reg emptyVC0_p1,
                  output reg emptyVC1_p1);



	// Generador de señal de reloj
	initial clk <= 0;
	always #1 clk = ~clk;

	initial
	begin
		$dumpfile("test.vcd");	// Archivo de salida para
     		$dumpvars(0,testbench); 	// GTKWave

		// secuencia de pruebas
	   reset_L <= 0;
		 VC0_p0 <= 5'b00001;
		 VC1_p0 <= 5'b00010;
		 VC0_p1 <= 5'b00011;
		 VC1_p1 <= 5'b00100;
		 validBits <=0;
		 emptyVC0_p0 <= 1;
		 emptyVC1_p0 <= 1;
		 emptyVC0_p1 <= 1;
		 emptyVC1_p1 <= 1;


	   @(posedge clk);
	   reset_L <= 1;

	   #6 @(posedge clk);
		 emptyVC0_p0 <= 0;

		 @(posedge clk);
		 VC0_p0 <= 5'b10010;

		 @(posedge clk);
		 VC0_p0 <= 5'b11111;
		 emptyVC0_p0 <= 1;
		 emptyVC0_p1 <= 0;

		 @(posedge clk);
		 VC0_p1 <= 5'b11000;

		 #20 @(posedge clk);
		 VC0_p1 <= 5'b11001;


	   #20 $finish;

	end

endmodule
