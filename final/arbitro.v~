`include "roundRobin.v"


module arbitro (  input clk,
                  input reset_L,
                  input [4:0] VC0_p0,
                  input [4:0] VC1_p0,
                  input [4:0] VC0_p1,
                  input [4:0] VC1_p1,
                  input [3:0] validBits,
                  input emptyVC0_p0,
                  input emptyVC1_p0,
                  input emptyVC0_p1,
                  input emptyVC1_p1,
                  output popVC0_0,
                  output popVC1_0,
                  output popVC0_1,
                  output popVC1_1,
                  output reg [4:0] dataOut_0,
                  output reg [4:0] dataOut_1,
                  output reg [1:0] validBitsOut);


  reg request0_VC0, request1_VC0, request0_VC1, request1_VC1;
  wire selectMUX_VC0, selectMUX_VC1;
  wire validMux_VCO, validMux_VC1;
  reg [4:0] muxVC0_muxMulti, muxVC1_muxMulti;
  reg [5:0] muxMultiOut;
  reg validMuxVC0, validMuxVC1, validMuxMulti;

  roundRobin roundRobinVC0 (  .clk(clk),
                              .reset_L(reset_L),
                              .request0(request0_VC0),
                              .request1(request1_VC0),
                              .portMux(selectMUX_VC0),
                              .validMux(validMux_VC0),
                              .pop_0(popVC0_0),
                              .pop_1(popVC0_1));

  roundRobin roundRobinVC1 (  .clk(clk),
                              .reset_L(reset_L),
                              .request0(request0_VC1),
                              .request1(request1_VC1),
                              .portMux(selectMUX_VC1),
                              .validMux(validMux_VC1),
                              .pop_0(popVC1_0),
                              .pop_1(popVC1_1));

  always @ (posedge clk) begin
    if(~reset_L) begin
      dataOut_0 <= 0;
      dataOut_1 <= 0;
      muxVC0_muxMulti <= 0;
      muxVC1_muxMulti <= 0;
      muxMultiOut <= 0;
      validBitsOut <= 0;
      validMuxVC1 <= 0;
      validMuxVC0 <= 0;
    end
    else begin
      muxVC0_muxMulti <= (selectMUX_VC0 ? VC0_p1 : VC0_p0);
      validMuxVC0 <= (selectMUX_VC0 ? validBits[1] : validBits[0]);
      muxVC1_muxMulti <= (selectMUX_VC1 ? VC1_p1 : VC1_p0);
      validMuxVC1 <= (selectMUX_VC1 ? validBits[3] : validBits[2]);
      muxMultiOut <= (validMux_VC0 ? {1'b1, muxVC1_muxMulti} : {1'b0, muxVC0_muxMulti});
      validMuxMulti <= (validMux_VC0 ? validMuxVC1 : validMuxVC0);

      if(~muxMultiOut[4]) begin
        dataOut_0 <= {muxMultiOut[5], muxMultiOut[0+:4]};
        validBitsOut[0] <= validMuxVC0;
      end
      else begin
        dataOut_1 <= {muxMultiOut[5], muxMultiOut[0+:4]};
        validBitsOut[1] <= validMuxVC1;
      end

    end
  end



  always @ ( * ) begin
    request0_VC0 = ~emptyVC0_p0;
    request1_VC0 = ~emptyVC0_p1;
    request0_VC1 = (emptyVC0_p0 & emptyVC0_p1) & ~emptyVC1_p0;
    request1_VC1 = (emptyVC0_p0 & emptyVC0_p1) & ~emptyVC1_p1;
  end

endmodule //arbitro
