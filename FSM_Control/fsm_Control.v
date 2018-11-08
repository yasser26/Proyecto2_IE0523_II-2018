

module fsmControl  ( input clk,
              input reset_L,
              input init,
              input [7:0] umbral_VCFC,
              input FIFO_error,
              input FIFO_empty,
              output reg [7:0] umbrales_VCFC,
              output reg active,
              output reg idle,
              output reg error);

  parameter RESET = 5'b00001;
  parameter INIT = 5'b00010;
  parameter IDLE = 5'b00100;
  parameter ACTIVE = 5'b01000;
  parameter ERROR = 5'b10000;

  reg [4:0] state, nxt_state;
  reg [7:0] nxt_umbrales;

  always @ ( posedge clk ) begin
    if (~reset_L) begin // Reinicio de senales
      state <= RESET;


    end
    else begin
      state <= nxt_state;
    end
  end

  always @ ( * ) begin
    error = 0;
    active = 0;
    idle = 0;
    umbrales_VCFC = 0;
    nxt_state = state;

    case(state)
      RESET: begin
        if (init)
          nxt_state = INIT;
      end

      INIT: begin
        umbrales_VCFC = umbral_VCFC;
        if (FIFO_error)
          nxt_state = ERROR;
        else
          nxt_state = IDLE;

      end

      IDLE: begin
        umbrales_VCFC = umbral_VCFC;
        if (FIFO_error)
          nxt_state = ERROR;
        else begin
          idle = 1;
          if (~FIFO_empty) begin
            idle = 0;
            nxt_state = ACTIVE;
          end

        end

      end

    ACTIVE: begin
      umbrales_VCFC = umbral_VCFC;
      idle = 0;
      active = 1;
      if (FIFO_error) begin
        active = 0;
        nxt_state = ERROR;
      end


    end

    ERROR: begin
      error = 1;
      if (reset_L)
        nxt_state = RESET;

    end
    default:
      nxt_state = RESET;

    endcase

  end


endmodule //fsm
