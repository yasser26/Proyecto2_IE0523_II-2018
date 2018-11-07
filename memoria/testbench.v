`timescale 1s/1ns
`include"probador.v"
`include "memoria.v"
`include "memoriaSynth.v"
`include "cmos_cells.v"

module testbench();
   parameter ADDR_WIDTH = 4;
   parameter BUS_SIZE = 32;
   // No modificar estos parametros
   parameter MEM_LENGTH = 1 << ADDR_WIDTH;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [ADDR_WIDTH-1:0] addressR;		// From prob of probador.v
   wire [ADDR_WIDTH-1:0] addressW;		// From prob of probador.v
   wire			clk;			// From prob of probador.v
   wire [BUS_SIZE-1:0]	data_in;		// From prob of probador.v
   wire [BUS_SIZE-1:0]	data_out_synth;		// From mem of memoria.v, ..., Couldn't Merge
   wire [BUS_SIZE-1:0]	data_out_cond;
   wire			read;			// From prob of probador.v
   wire			write;			// From prob of probador.v
   // End of automatics
   memoria mem (/*AUTOINST*/
		// Outputs
		.data_out		(data_out_cond[BUS_SIZE-1:0]),
		// Inputs
		.clk			(clk),
		.read			(read),
		.write			(write),
		.data_in		(data_in[BUS_SIZE-1:0]),
		.addressR		(addressR[ADDR_WIDTH-1:0]),
		.addressW		(addressW[ADDR_WIDTH-1:0]));
   memoriaSynth memSyn(/*AUTOINST*/
		       // Outputs
		       .data_out	(data_out_synth[31:0]),
		       // Inputs
		       .addressR	(addressR[3:0]),
		       .addressW	(addressW[3:0]),
		       .clk		(clk),
		       .data_in		(data_in[31:0]),
		       .read		(read),
		       .write		(write));
   
   probador prob(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .read			(read),
		 .write			(write),
		 .data_in		(data_in[BUS_SIZE-1:0]),
		 .addressR		(addressR[ADDR_WIDTH-1:0]),
		 .addressW		(addressW[ADDR_WIDTH-1:0]),
		 // Inputs
		 .data_out_synth	(data_out_synth[BUS_SIZE-1:0]),
		 .data_out_cond		(data_out_cond[BUS_SIZE-1:0]));
   
   endmodule 
