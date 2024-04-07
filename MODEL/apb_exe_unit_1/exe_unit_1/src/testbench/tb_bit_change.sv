//`include "../modules/bit_change.sv"
`include "%INCLUDE%"

module testbench;

    parameter N = 8;

    reg signed [N-1:0] a;
    reg signed [N-1:0] b;

    wire signed [N-1:0] result;
    wire error;

    bit_change #(N) bch (
        .A(a),
        .B(b),
        .result(result),
        .error(error)
    );

    initial begin
        $dumpfile("./testbench/sim/bit_change.vcd");
        $dumpvars(0, testbench);

        $display("\nTest modułu bit_change\n");

        a = 8'b10101010;
        b = 0;
        #10;
        $display("A: %b", a);
        $display("B: %d", b);
        $display("result: %b", result);
        $display("error: %b\n", error);

        a = 8'b10101010;
        b = 2;
        #10;
        $display("A: %b", a);
        $display("B: %d", b);
        $display("result: %b", result);
        $display("error: %b\n", error);

        a = 8'b10101010;
        b = -2;
        #10;
        $display("A: %b", a);
        $display("B: %d", b);
        $display("result: %b", result);
        $display("error: %b\n", error);

        a = 8'b10101010;
        b = 9;
        #10;
        $display("A: %b", a);
        $display("B: %d", b);
        $display("result: %b", result);
        $display("error: %b\n", error);

        $finish;
    end
endmodule