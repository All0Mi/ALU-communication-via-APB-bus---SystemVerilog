module MUX #(parameter M = 8, parameter N = 2)
(input logic [M-1:0] SET,
input logic [M-1:0] SHIFT,
input logic [M-1:0] COMPARATOR,
input logic [M-1:0] CHANGER,
input [N-1:0] testcase,
output logic [M-1:0] modul);

always_comb
begin
    case(testcase)
    2'b00: modul = SET;
    2'b01: modul = SHIFT;
    2'b10: modul = COMPARATOR;
    2'b11: modul = CHANGER;
    endcase
end

endmodule

