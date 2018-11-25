module roundRobin ( input clk,
                    input reset_L,
                    input request0,
                    input request1,
                    output reg portMux,
                    output reg validMux,
                    output reg pop_0,
                    output reg pop_1);

  reg valid;

  always @ (posedge clk) begin
    if (~reset_L) begin
      portMux <= 0;
      validMux <= 0;
    end
    else begin
      if(valid) begin
        validMux <= 0;

        if(request0 && request1)
          portMux <= ~portMux;
        else begin
          portMux <= 0;
          if (~request0 && request1)
            portMux <= 1;
        end

      end
      else begin
        validMux <= 1;
        portMux <= 0;
      end

    end

  end

  always @ (*) begin
    if(~request0 && ~request1)
      valid = 0;
    else
      valid = 1;

    if (~reset_L) begin
      pop_0 = 0;
      pop_1 = 0;

    end
    else begin
      if(valid) begin
 	if(request0 && request1) begin
         if(portMux) begin
            pop_1 = 1;
            pop_0 = 0;
          end
          else begin
            pop_1 = 0;
            pop_0 = 1;

          end

	end
	else begin
	    if (~request0 && request1) begin
            	pop_1 = 1;
            	pop_0 = 0;
          end else begin
		pop_1 = 0;
            	pop_0 = 1;
	    end

	end

      end
      else begin
	pop_0 = 0;
        pop_1 = 0;

      end

    end

  end

endmodule //arbitro
