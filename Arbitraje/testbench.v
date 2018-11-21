`timescale 1s / 1s
`include "probador.v"
`include "arbitroEstructural.v"
`include "arbitro.v"
`include "cmos_cells.v"

// módulo banco de pruebas del diseño
module testbench;

   wire [4:0] VC0_p0, VC1_p0, VC0_p1, VC1_p1;
   wire [3:0] validBits;
   wire [4:0] dataOut_0_condu, dataOut_1_condu, dataOut_0_estru, dataOut_1_estru;

   arbitro arbitroCondu(	.clk(clk),
				.reset_L(reset_L),
				.VC0_p0(VC0_p0),
				.VC1_p0(VC1_p0),
				.VC0_p1(VC0_p1),
				.VC1_p1(VC1_p1),
        .validBits(validBits),
        .emptyVC0_p0(emptyVC0_p0),
        .emptyVC1_p0(emptyVC1_p0),
        .emptyVC0_p1(emptyVC0_p1),
        .emptyVC1_p1(emptyVC1_p1),
				.popVC0_0(popVC0_0_condu),
        .popVC1_0(popVC1_0_condu),
        .popVC0_1(popVC0_1_condu),
        .popVC1_1(popVC1_1_condu),
        .dataOut_0(dataOut_0_condu),
        .dataOut_1(dataOut_1_condu));


   arbitroEstructural arbitroEstru(	.clk(clk),
       .reset_L(reset_L),
       .VC0_p0(VC0_p0),
       .VC1_p0(VC1_p0),
       .VC0_p1(VC0_p1),
       .VC1_p1(VC1_p1),
        .validBits(validBits),
        .emptyVC0_p0(emptyVC0_p0),
        .emptyVC1_p0(emptyVC1_p0),
        .emptyVC0_p1(emptyVC0_p1),
        .emptyVC1_p1(emptyVC1_p1),
        .popVC0_0(popVC0_0_estru),
        .popVC1_0(popVC1_0_estru),
        .popVC0_1(popVC0_1_estru),
        .popVC1_1(popVC1_1_estru),
        .dataOut_0(dataOut_0_estru),
        .dataOut_1(dataOut_1_estru));



   probador prob(	.popVC0_0_condu(popVC0_0_condu),
			.popVC1_0_condu(popVC1_0_condu),
			.popVC0_1_condu(popVC0_1_condu),
      .popVC1_1_condu(popVC1_1_condu),
      .dataOut0_condu(dataOut_0_condu),
      .dataOut1_condu(dataOut_1_condu),
      .popVC0_0_estru(popVC0_0_estru),
   		.popVC1_0_estru(popVC1_0_estru),
   		.popVC0_1_estru(popVC0_1_estru),
      .popVC1_1_estru(popVC1_1_estru),
      .dataOut0_estru(dataOut_0_estru),
      .dataOut1_estru(dataOut_1_estru),
		 	.clk(clk),
		 	.reset_L(reset_L),
			.VC0_p0(VC0_p0),
      .VC1_p0(VC1_p0),
      .VC0_p1(VC0_p1),
      .VC1_p1(VC1_p1),
      .validBits(validBits),
      .emptyVC0_p0(emptyVC0_p0),
      .emptyVC1_p0(emptyVC1_p0),
      .emptyVC0_p1(emptyVC0_p1),
      .emptyVC1_p1(emptyVC1_p1));

endmodule
