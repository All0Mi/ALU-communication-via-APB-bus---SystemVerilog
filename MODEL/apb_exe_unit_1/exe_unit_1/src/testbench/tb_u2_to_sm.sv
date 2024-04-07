//`include "./modules/u2_to_sm.sv"
`include "%INCLUDE%"

module tb_u2_to_sm;

    parameter N = 8;

    reg [N-1:0] u2_number;
    wire [N-1:0] result; 
    wire error;          

    u2_to_sm #(N) u2_to_sm_inst (
        .u2_number(u2_number),
        .sm_number(result),
        .error(error)
    );

    initial begin
        $dumpfile("./testbench/sim/tb_u2_to_sm.vcd");
        $dumpvars(0, tb_u2_to_sm);

        $display("\nTest modułu u2_to_sm\n");

        u2_number = 8'b01111000; // Liczba dodatnia w formacie U2
        #10;
        $display("Input U2: %b", u2_number);
        $display("Output SM: %b", result);
        $display("Error: %b\n", error);

        u2_number = 8'b11111000; // Liczba ujemna w formacie U2
        #10;
        $display("Input U2: %b", u2_number);
        $display("Output SM: %b", result);
        $display("Error: %b\n", error);

        u2_number = 8'b10000000; // Spełnienie warunku przepełnienia
        #10;
        $display("Input U2: %b", u2_number);
        $display("Output SM: %b", result);
        $display("Error: %b\n", error);

        $finish;
    end

endmodule
