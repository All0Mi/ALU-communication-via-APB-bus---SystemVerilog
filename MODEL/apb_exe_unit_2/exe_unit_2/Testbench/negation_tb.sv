`timescale 1ps/1ps
`include "negation.sv"
`include "negation_rtl.sv"
module negation_tb;
    parameter BITS = 4;

    logic [BITS-1:0] s_i_argA;
    logic [BITS-1:0] s_o_result;
    logic [BITS-1:0] sn_o_result;
    logic s_error;
    logic sn_error;

    negation #(BITS) s_negation (
        .i_argA(s_i_argA),
        .o_result(s_o_result),
        .error(s_error)
    );
    negation_rtl #(BITS) sn_negation(
        .i_argA(s_i_argA),
        .o_result(sn_o_result),
        .error(sn_error)
    );

    initial begin 
        $dumpfile("signals_negation.vcd");
        $dumpvars(0, negation_tb);

        s_i_argA = 'b0001;
        #4
        s_i_argA = 'b1000;
        #4
        s_i_argA = 'b1001;
        #4
        s_i_argA = 'b1101;
        #4
        s_i_argA = 'b1111;
    end
endmodule
