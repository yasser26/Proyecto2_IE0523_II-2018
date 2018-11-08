`timescale 1s / 1s
`include "probador.v"
`include "fsm_ControlEstructural.v"
`include "fsm_Control.v"
`include "cmos_cells.v"

// módulo banco de pruebas del diseño
module testbench;
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			FIFO_error;		// From prob of probador.v
   wire 		FIFO_empty; 		
   wire			active__condu;			// From fsm of fsmControl.v
   wire			clk;			// From prob of probador.v
   wire			error_condu;			// From fsm of fsmControl.v
   wire			idle_condu;			// From fsm of fsmControl.v
   wire			init;			// From prob of probador.v
   wire			reset_L;		// From prob of probador.v
   wire	[7:0] umbral_VCFC;		// From prob of probador.v
   wire	[7:0] umbrales_VCFC_condu;		// From fsm of fsmControl.v
   wire [7:0] umbrales_VCFC_estru;
   wire  	        	active_estru;
   wire			idle_estru;
   wire			error_estru;
   // End of automatics
   fsmControl fsmCondu(/*AUTOINST*/
		  // Outputs
		  .umbrales_VCFC	(umbrales_VCFC_condu),
		  .active		(active_condu),
		  .idle			(idle_condu),
		  .error		(error_condu),
		  // Inputs
		  .clk			(clk),
		  .reset_L		(reset_L),
		  .init			(init),
		  .umbral_VCFC		(umbral_VCFC),
		  .FIFO_error		(FIFO_error),
		  .FIFO_empty		(FIFO_empty));

fsmControlEstructural fsmEstru(/*AUTOINST*/
		  // Outputs
		  .umbrales_VCFC	(umbrales_VCFC_estru),
		  .active		(active_estru),
		  .idle			(idle_estru),
		  .error		(error_estru),
		  // Inputs
		  .clk			(clk),
		  .reset_L		(reset_L),
		  .init			(init),
		  .umbral_VCFC		(umbral_VCFC),
		  .FIFO_error		(FIFO_error),
		  .FIFO_empty		(FIFO_empty));

   probador prob(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .reset_L		(reset_L),
		 .init			(init),
		 .umbral_VCFC		(umbral_VCFC),
		 .FIFO_error		(FIFO_error),
		 .FIFO_empty		(FIFO_empty),
		 // Inputs
		 .umbrales_VCFC_condu		(umbrales_VCFC_condu),
		 .active_condu		        (active_condu),
		 .idle_condu			(idle_condu),
		 .error_condu			(error_condu),
		 .umbrales_VCFC_estru		(umbrales_VCFC_estru),
		 .active_estru		        (active_estru),
		 .idle_estru			(idle_estru),
		 .error_estru			(error_estru));
   
endmodule
