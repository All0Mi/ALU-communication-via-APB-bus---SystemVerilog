`timescale 1ps/1ps
`include "changebit.sv"
`include "changebit_rtl.sv"

module changebit_tb;
    parameter BITS = 4;

    logic [BITS-1:0] s_i_argA;
    logic [BITS-1:0] s_i_argB;
    logic [BITS-1:0] s_o_result;
    logic [BITS-1:0] sn_o_result;
    logic s_error;
    logic sn_error;

    changebit #(BITS) s_changebit (
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .o_result(s_o_result),
        .error(s_error)
    );
    changebit_rtl #(BITS) sn_changebit (
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .o_result(sn_o_result),
        .error(sn_error)
    );

    initial begin 
        $dumpfile("signals_changebit.vcd");
        $dumpvars(0, changebit_tb);

        s_i_argA = 4'b0001;
        s_i_argB = 2;
        #4
        s_i_argA = 4'b1000;
        s_i_argB = 1;
        #4
        s_i_argA = 4'b0101;
        s_i_argB = 4;
        #4
        s_i_argA = 4'b1111;
        s_i_argB = 0;

    end
endmodule
