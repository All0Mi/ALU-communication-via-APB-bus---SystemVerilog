//`include "../modules/compare.sv"
`include "%INCLUDE%"

module testbench;

    parameter N = 8;

    reg signed [N-1:0] a;
    reg signed [N-1:0] b;

    wire signed [N-1:0] result;

    compare #(N) cmp (
        .A(a),
        .B(b),
        .result(result)
    );

    initial begin
        $dumpfile("./testbench/sim/compare.vcd");
        $dumpvars(0, testbench);

        $display("\nTest modułu compare\n");

        a = 6;
        b = 8;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        a = 8;
        b = 6;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        a = -6;
        b = 8;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        a = 6;
        b = -8;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        a = -6;
        b = -8;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        a = -8;
        b = -6;
        #10;
        $display("A: %d\tB: %d\tresult: %d", a, b, result);

        $finish;
    end
endmodule
