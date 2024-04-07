`timescale 1ps/1ps
`include "exe_unit_w22.sv"
`include "exe_unit_w22_rtl.sv"

module exe_unit_w22_tb;
    parameter BITS = 4;
    parameter N = 2;

    logic [BITS-1:0] s_i_argA;
    logic [BITS-1:0] s_i_argB;
    logic [N-1:0] s_i_oper;
    logic [BITS-1:0] s_o_result;
    logic [BITS-1:0] sn_o_result;
    logic [3:0] s_o_status;
    logic [3:0] sn_o_status;
    logic s_i_rsn;
    logic s_i_clk = 0;

    ALU #(BITS, N) s_exe_unit_w22 (
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .i_oper(s_i_oper),
        .o_result(s_o_result),
        .o_status(s_o_status),
        .i_rsn(s_i_rsn),
        .i_clk(s_i_clk)
    );
    ALU_rtl #(BITS, N) sn_exe_unit_w22 (
        .i_argA(s_i_argA),
        .i_argB(s_i_argB),
        .i_oper(s_i_oper),
        .o_result(sn_o_result),
        .o_status(sn_o_status),
        .i_rsn(s_i_rsn),
        .i_clk(s_i_clk)
    );

    always #2 s_i_clk = ~s_i_clk;

    initial begin 
        $dumpfile("signals_exe_unit_w22.vcd");
        $dumpvars(0, exe_unit_w22_tb);

        s_i_rsn = 0;
        s_i_oper = 'b00;
        s_i_argA = 'b0000;
        #4
        s_i_argA = 'b1000;
        #4
        s_i_rsn = 1;
        s_i_argA = 'b0001;
        #4
        s_i_argA = 'b1000;
        #4

        s_i_oper = 'b01;
        s_i_argA = 'b0010;
        s_i_argB = 'b0001;
        #4
        s_i_argA = 'b1000;
        s_i_argB = 'b1001;
        #4
        s_i_argA = 'b0001;
        s_i_argB = 'b1000;
        #4
        s_i_argA = 'b0100;
        s_i_argB = 'b0100;
        #4
        s_i_argA = 'b1001;
        s_i_argB = 'b1000;
        #4

        s_i_oper = 'b10;
        s_i_argA = 'b0000;
        s_i_argB = 'b1111;
        #4
        s_i_argA = 'b0000;
        s_i_argB = 'b0100;
        #4
        s_i_argA = 'b0000;
        s_i_argB = 'b0000;
        #4
        s_i_argA = 'b0000;
        s_i_argB = 'b0001;
        #4
        s_i_argA = 'b0100;
        s_i_argB = 'b0010;
        #4

        s_i_oper = 'b11;
        s_i_argA = 'b1000;
        #4
        s_i_argA = 'b0000;
        #4
        s_i_argA = 'b0001;
        #4
        s_i_argA = 'b1111;
        #4

        $finish;

    end
endmodule