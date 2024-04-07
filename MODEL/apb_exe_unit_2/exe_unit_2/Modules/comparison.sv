module comparison (i_argA, i_argB, o_result);
    parameter BITS = 4;

    input logic signed [BITS-1:0] i_argA;
    input logic signed [BITS-1:0] i_argB;
    output logic [BITS-1:0] o_result;

    always_comb begin
        if (i_argA > i_argB) 
        begin
            o_result = 'b1;
        end 
        else if (i_argA==i_argB)
        begin
            o_result = 'b1;
        end
        else 
        begin
            o_result = 'b0;
        end
    end
endmodule