module changebit (i_argA, i_argB, o_result, error);
    parameter BITS = 4;

    input logic [BITS-1:0] i_argA;   
    input logic signed [BITS-1:0] i_argB;
    output logic [BITS-1:0] o_result;
    output logic error;

always_comb
  begin
    if (i_argB < 0 || i_argB >= BITS)
    begin
      error = 1;
      o_result = i_argA;
    end
    else
    begin
      error = 0;
      o_result = i_argA | (1 << i_argB);
    end
  end
endmodule
