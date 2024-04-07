module negation (i_argA, o_result, error);
    parameter BITS = 4;

    input logic signed [BITS-1:0] i_argA;
    output logic signed [BITS-1:0] o_result;
    output logic error;

    always_comb
    begin
        if (i_argA == -(2**(BITS-1)))
        begin
            error = 1;
            o_result = i_argA;
        end
        else
        begin
            error = 0;
            o_result = ~i_argA + 1;
        end
    end
endmodule
