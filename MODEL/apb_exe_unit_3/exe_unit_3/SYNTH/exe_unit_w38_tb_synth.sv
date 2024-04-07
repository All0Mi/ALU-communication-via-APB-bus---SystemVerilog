`timescale 1ps/1ps
`include "./exe_unit_w38_synth.sv"


module testbench;
    parameter M = 8;
    logic [1:0] i_op;
    logic [M-1:0] i_argA;
    logic [M-1:0] i_argB;
    logic i_clk;
    logic i_reset;
    logic [M-1:0] result;
    logic [3:0] stat;
    
    exe_unit_w38_synth unit (.i_argA(i_argA), .i_argB(i_argB), .i_op(i_op), .i_reset(i_reset), .i_clk(i_clk), .o_result(result), .o_stat(stat));

    always #1 i_clk = ~(i_clk); //zegar

    initial begin
        $dumpfile("exe_unit_w38_synth.vcd");
        $dumpvars(0, testbench);

    //resetowanie
        i_reset = '0;
        #2
        i_reset = '1;
        
    //testing SET
        i_op = 2'b00;
        i_clk = '0;
        i_argA = 7;
        i_argB = 8'b11000001;
        #4
        i_argA = 7;  
        i_argB = 0;
        #4 
        i_argA = 7; 
        i_argB = 11;
        #4 
        i_argA = 8'b10110000; 
        i_argB = 8'b00000000;
        #4
        i_reset = '0;
        #10
    //testing SHIFT
        i_op = 2'b01;
        i_argA = 8; 
        i_argB = 8'b10110000;
        #4
        i_argA = 8'b11000011;
        i_argB = 5;
        #4
        i_argA = 8;
        i_argB = 5;
        #4
        i_reset = '0;
        #10
    //testing COMPARATOR
        i_op = 2'b10;
        i_argA = 11;
        i_argB = 14;
        #4
        i_argA = 11;
        i_argB = 9;
        #4
        i_argA = 10;
        i_argB = 10;
        #4
        i_reset = '0;
        #10
    //testing CHANGER
        i_op = 2'b11;
        i_argA = 8'b10001001;
        #4
        i_argA = 120;
        #4
        i_argA = -128;
        #4
        i_reset = '0;
        #10    
        $finish;
    end
    initial #120 $finish;
endmodule
