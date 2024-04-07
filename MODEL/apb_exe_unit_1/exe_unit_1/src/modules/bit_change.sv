module bit_change #(parameter N=8)(
    input logic [N-1:0] A,        // Wejście liczby A (N bitów)
    input logic [N-1:0] B,        // Wejście indeksu B (N bitów)
    output logic [N-1:0] result,  // Wyjście zmodyfikowane A
    output logic error            // Wyjście sygnalizujące błąd
);

always_comb begin
    if (B >= N || B < 0) begin
        error = 1;              // Ustaw flagę błędu jeżeli B jest poza zakresem
        result = A;             // Wyjście A bez zmian
    end
    else begin
        error = 0;               // Wyczyść flagę błędu jeżeli B jest w zakresie
        result = A | (1 << B);   // Ustaw B-ty bit A na 1
    end
end

endmodule