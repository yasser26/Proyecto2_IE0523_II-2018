`timescale 1s/1ns
`include "cmos_cells.v"
`include"probador.v"
`include "PCIE_trans.v"
`include "PCIE_Synth.v"

module testbench #(
parameter ADDR_WIDTH = 3,
parameter BUS_SIZE = 5,
parameter MEM_LENGTH = 1 << ADDR_WIDTH);
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From probador1 of probador.v
   wire			continue_VC0P0;		// From transac of PCIE_trans.v, ...
   wire			continue_VC0P1;		// From transac of PCIE_trans.v, ...
   wire			continue_VC1P0;		// From transac of PCIE_trans.v, ...
   wire			continue_VC1P1;		// From transac of PCIE_trans.v, ...
   wire [BUS_SIZE:0]	data_p0;		// From probador1 of probador.v
   wire [BUS_SIZE:0]	data_p1;		// From probador1 of probador.v
   wire [4:0]		out_p0;			// From transac of PCIE_trans.v, ...
   wire [4:0]		out_p1;			// From transac of PCIE_trans.v, ...
   wire			pause_VC0P0;		// From transac of PCIE_trans.v, ...
   wire			pause_VC0P1;		// From transac of PCIE_trans.v, ...
   wire			pause_VC1P0;		// From transac of PCIE_trans.v, ...
   wire			pause_VC1P1;		// From transac of PCIE_trans.v, ...
   wire			reset;			// From probador1 of probador.v
   wire [3:0]		umbralA;		// From probador1 of probador.v
   wire [3:0]		umbralB;		// From probador1 of probador.v
   wire			valid_p0;		// From probador1 of probador.v
   wire			valid_p1;		// From probador1 of probador.v

   wire			continue_VC0P0E;		// From transac of PCIE_trans.v, ...
   wire			continue_VC0P1E;		// From transac of PCIE_trans.v, ...
   wire			continue_VC1P0E;		// From transac of PCIE_trans.v, ...
   wire			continue_VC1P1E;		// From transac of PCIE_trans.v, ...
   wire [4:0] 		out_p0E;			// From transac of PCIE_trans.v, ...
   wire [4:0]		out_p1E;			// From transac of PCIE_trans.v, ...
   wire			pause_VC0P0E;		// From transac of PCIE_trans.v, ...
   wire			pause_VC0P1E;		// From transac of PCIE_trans.v, ...
   wire			pause_VC1P0E;		// From transac of PCIE_trans.v, ...
   wire			pause_VC1P1E;		// From transac of PCIE_trans.v, ...
  
   
   // End of automatics
  
   probador probador1(/*AUTOINST*/
		      // Outputs
		      .clk		(clk),
		      .reset		(reset),
		      .data_p0		(data_p0),
		      .valid_p0		(valid_p0),
		      .data_p1		(data_p1),
		      .valid_p1		(valid_p1),
		      .umbralA		(umbralA),
		      .umbralB		(umbralB),
		      // Inputs
		      .out_p1		(out_p1[BUS_SIZE-1:0]),
		      .out_p0		(out_p0[BUS_SIZE-1:0]),
		      .continue_VC0P0	(continue_VC0P0),
		      .continue_VC1P0	(continue_VC1P0),
		      .continue_VC0P1	(continue_VC0P1),
		      .continue_VC1P1	(continue_VC1P1),
		      .pause_VC0P0	(pause_VC0P0),
		      .pause_VC1P0	(pause_VC1P0),
		      .pause_VC0P1	(pause_VC0P1),
		      .pause_VC1P1	(pause_VC1P1));
   
   PCIE_trans transac(/*AUTOINST*/
		      // Outputs
		      .out_p0		(out_p0[4:0]),
		      .out_p1		(out_p1[4:0]),
		      .pause_VC0P0	(pause_VC0P0),
		      .pause_VC1P0	(pause_VC1P0),
		      .pause_VC0P1	(pause_VC0P1),
		      .pause_VC1P1	(pause_VC1P1),
		      .continue_VC0P0	(continue_VC0P0),
		      .continue_VC1P0	(continue_VC1P0),
		      .continue_VC0P1	(continue_VC0P1),
		      .continue_VC1P1	(continue_VC1P1),
		      // Inputs
		      .clk		(clk),
		      .reset		(reset),
		      .valid_p0		(valid_p0),
		      .valid_p1		(valid_p1),
		      .data_p0		(data_p0[5:0]),
		      .data_p1		(data_p1[5:0]),
		      .umbralA		(umbralA[3:0]),
		      .umbralB		(umbralB[3:0]));

   PCIE_Synth transacSynth(/*AUTOINST*/
			   // Outputs
			   .continue_VC0P0	(continue_VC0P0E),
			   .continue_VC0P1	(continue_VC0P1E),
			   .continue_VC1P0	(continue_VC1P0E),
			   .continue_VC1P1	(continue_VC1P1E),
			   .out_p0		(out_p0E[4:0]),
			   .out_p1		(out_p1E[4:0]),
			   .pause_VC0P0		(pause_VC0P0E),
			   .pause_VC0P1		(pause_VC0P1E),
			   .pause_VC1P0		(pause_VC1P0E),
			   .pause_VC1P1		(pause_VC1P1E),
			   // Inputs
			   .clk			(clk),
			   .data_p0		(data_p0[5:0]),
			   .data_p1		(data_p1[5:0]),
			   .reset		(reset),
			   .umbralA		(umbralA[3:0]),
			   .umbralB		(umbralB[3:0]),
			   .valid_p0		(valid_p0),
			   .valid_p1		(valid_p1));
   

    //integer		idx;
   /*initial begin
     
      for (idx = 0; idx < 8; idx = idx + 1) begin
			$dumpvars(1,transac.fifo_VC0P0.channel.mem[idx]);
		end
   end*/
   endmodule 
