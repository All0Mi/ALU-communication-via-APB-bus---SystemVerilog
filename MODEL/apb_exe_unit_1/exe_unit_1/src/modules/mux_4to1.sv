module mux_4to1 #(parameter N=8)(
  input [N-1:0] in0,        // Linie danych wejściowych N-bitowych
  input [N-1:0] in1,
  input [N-1:0] in2,
  input [N-1:0] in3,
  input [1:0] sel,          // Linie selekcji w kodzie Graya (2-bitowy)
  output logic [N-1:0] out    // Linia danych wyjściowych N-bitowa
);

  always_comb begin
    case(sel)
      2'b00: out = in0;
      2'b01: out = in1;
      2'b11: out = in2;
      2'b10: out = in3;
    endcase
  end

endmodule
