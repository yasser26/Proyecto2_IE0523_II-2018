`timescale 1s / 1s
`include "probador.v"
`include "roundRobinEstructural.v"
`include "roundRobin.v"
`include "cmos_cells.v"

// módulo banco de pruebas del diseño
module testbench;


   roundRobin roundRobinCondu(	.clk(clk),
				.reset_L(reset_L),
				.request0(request0),
				.request1(request1),
				.portMux(portMux_condu),
				.validMux(validMux_condu),
				.pop_0(pop0_condu),
        .pop_1(pop1_condu));

   roundRobinEstructural roundRobinEstru(	.clk(clk),
						.reset_L(reset_L),
						.request0(request0),
						.request1(request1),
						.portMux(portMux_estru),
						.validMux(validMux_estru),
            .pop_0(pop0_estru),
            .pop_1(pop1_estru));

   probador prob(	.portMux_condu(portMux_condu),
			.validMux_condu(validMux_condu),
			.pop0_condu(pop0_condu),
      .pop1_condu(pop1_condu),
			.portMux_estru(portMux_estru),
			.validMux_estru(validMux_estru),
			.pop0_estru(pop0_estru),
      .pop1_estru(pop1_estru),
		 	.clk(clk),
		 	.reset_L(reset_L),
			.request0(request0),
			.request1(request1));

endmodule
