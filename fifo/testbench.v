`timescale 1s/1ns
`include"probador.v"
`include "fifo.v"
`include "fifoSynth.v"
`include "cmos_cells.v"

module testbench();
   parameter ADDR_WIDTH = 3;
   parameter BUS_SIZE = 5;
   // No modificar estos parametros
   parameter MEM_LENGTH = 1 << ADDR_WIDTH;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From prob of probador.v
   wire			continua;		// From each of fifo.v
   wire [BUS_SIZE-1:0]	data_in;		// From prob of probador.v
   wire [BUS_SIZE-1:0]	data_out;		// From each of fifo.v
   wire			empty;			// From each of fifo.v
   wire			pause;			// From each of fifo.v
   wire			pop;			// From prob of probador.v
   wire			push;			// From prob of probador.v
   wire			reset;			// From prob of probador.v
   wire			valid;			// From prob of probador.v
wire			valid_out;
   wire			valid_outE;
   wire [BUS_SIZE-1:0]	data_outE;		// From each of fifo.v
   wire			emptyE;			// From each of fifo.v
   wire			pauseE;			// From each of fifo.v
   wire			continuaE;		// From each of fifo.v
   // End of automatics
   fifo each (/*AUTOINST*/
	      // Outputs
	      .pause			(pause),
	      .continua			(continua),
	      .empty			(empty),
	      .data_out			(data_out[BUS_SIZE-1:0]),
	      .valid_out(valid_out),
	      // Inputs
	      .clk			(clk),
	      .reset			(reset),
	      .pop			(pop),
	      .push			(push),
	      .data_in			(data_in[BUS_SIZE-1:0]),
	      .valid (valid));
   
    fifoSynth eachSynth (/*AUTOINST*/
	      // Outputs
	      .pause			(pauseE),
	      .continua			(continuaE),
	      .empty			(emptyE),
	      .data_out			(data_outE[BUS_SIZE-1:0]),
			 .valid_out(valid_outE),		 
	      // Inputs
	      .clk			(clk),
	      .reset			(reset),
	      .pop			(pop),
	      .push			(push),
	      .data_in			(data_in[BUS_SIZE-1:0]),
	      .valid (valid));    
   
   probador prob(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .reset			(reset),
		 .push			(push),
		 .pop			(pop),
		 .data_in		(data_in[BUS_SIZE-1:0]),
		 .valid			(valid),
		 // Inputs Cond
		 .empty			(empty),
		 .data_out_cond		(data_out[BUS_SIZE-1:0]),
		 .continua		(continua),
		 .pause			(pause),
		 .valid_out(valid_out),
		 // Inputs Est
		 .data_out_synth (data_outE),
		 .continua_syn		(continuaE),
		 .pause_syn			(pause),
		 .valid_out_syn(valid_outE),
		 .empty_syn		(emptyE)
		 
);
   
   endmodule 
