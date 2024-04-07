module left_shift #(parameter N=8)(
    input logic signed [N-1:0] A,         // Wejście A (Liczba o N bitach w formacie ze znakiem)
    input logic signed [N-1:0] B,         // Wejście B (Liczba o N bitach w formacie ze znakiem)
    output logic signed [N-1:0] result,   // Wynik przesunięcia A o B bitów
    output logic error                    // Sygnał błędu jeśli B < 0
);

reg signed [N-1:0] shifted_A;

// always_comb powoduje dodatkowe błędy 
always @(*) begin
    result = 0;     
    if (B < 0) begin                    // Gdy B jest ujemne, wynik jest niezdefiniowany
        error = 1;                      // Ustaw sygnał błędu na wysoki
    end
    else begin                          
        error = 0;
        shifted_A = A <<< B;                    // Przesuń A o B w lewo
        result = {A[N-1], shifted_A[N-2:0]};    // Połącz bit znaku z A razem z fragmentem przesuniętej wartości
    end
end

endmodule
