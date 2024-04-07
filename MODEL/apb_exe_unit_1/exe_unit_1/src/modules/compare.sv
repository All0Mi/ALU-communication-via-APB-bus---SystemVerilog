module compare #(parameter N=8)(
    input logic signed [N-1:0] A,         // Wejście A (Liczba o N bitach w formacie ze znakiem)
    input logic signed [N-1:0] B,         // Wejście B (Liczba o N bitach w formacie ze znakiem)
    output logic [N-1:0] result           // Wynik porównania A < B
);

always_comb begin
    if( A < B) begin
        result = 'b1;
    end else begin
        result = 'b0;
    end
end

endmodule
