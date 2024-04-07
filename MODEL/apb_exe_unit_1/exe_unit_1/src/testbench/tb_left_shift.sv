//`include "./modules/left_shift.sv"
`include "%INCLUDE%"

module testbench;

    parameter N = 8;

    reg signed [N-1:0] a;
    reg signed [N-1:0] b;

    wire signed [N-1:0] result;
    wire error;

    left_shift #(N) uut (
        .A(a),
        .B(b),
        .result(result),
        .error(error)
    );

    initial begin
        $dumpfile("./testbench/sim/left_shift.vcd");
        $dumpvars(0, testbench);

        $display("\nTest modułu left_shift\n");

        // Przypadek testowy 1: Pozytywne przesunięcie
        a = 8'b00011010;
        b = 2;
        #10;
        $display("Test 1 - Przesunięcie standardowe");
        $display("A: %b (%d)", a, a);
        $display("B: %b (%d)", b, b);
        $display("Result: %b (%d)", result, result);
        $display("Error: %b\n", error);

        // Przypadek testowy 2: A jest ujemne
        a = -8'b00011010; 
        b = 2; 
        #10;
        $display("Test 2 - Przesunięcie liczby ujemnej");
        $display("A: %b (%d)", a, a);
        $display("B: %b (%d)", b, b);
        $display("Result: %b (%d)", result, result);
        $display("Error: %b\n", error);;

        // Przypadek testowy 3: Ujemne przesunięcie (warunek błędu)
        b = -3;
        #10;
        $display("Test 3 - Przesunięcie o wartość ujemną");
        $display("A: %b (%d)", a, a);
        $display("B: %b (%d)", b, b);
        $display("Result: %b (%d)", result, result);
        $display("Error: %b\n", error);

        // Zakończ symulację
        $finish;
    end
endmodule
