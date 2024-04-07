`timescale 1ps/1ps
`include "comparison.sv"
`include "comparison_rtl.sv"
module comparison_tb;
    parameter BITS = 4;

    logic [BITS-1:0] s_i_argA;
    logic [BITS-1:0] s_i_argB;
    logic [BITS-1:0] s_o_result;
    logic [BITS-1:0] sn_o_result;

    comparison #(BITS) s_comparison (
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .o_result(s_o_result)
    );
        comparison_rtl #(BITS) sn_comparison(
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .o_result(sn_o_result)
    );

    initial begin 
        $dumpfile("signals_comparison.vcd");
        $dumpvars(0, comparison_tb);

        s_i_argA = 'b0001;
        s_i_argB = 'b0001;
        #4
        s_i_argA = 'b1000;
        s_i_argB = 'b0001;
        #4
        s_i_argA = 'b0101;
        s_i_argB = 'b0011;
        #4
        s_i_argA = 'b1111;
        s_i_argB = 'b0001;
        #4
        s_i_argA = 'b0001;
        s_i_argB = 'b0111;
    end
endmodule
