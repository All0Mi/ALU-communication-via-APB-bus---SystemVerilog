module u2_to_sm #(parameter N=8)(
    input logic [N-1:0] u2_number,    // Wejście U2 (Liczba o N bitach)
    output logic [N-1:0] sm_number,   // Wyjście Znak-Moduł
    output logic error                // Sygnał błędu
);

// always_comb powoduje dodatkowe błędy
always @(*) begin
    if (u2_number[N-1] == 1) begin
        sm_number = {1'b1, {~u2_number[N-2:0]}} + 1; // Konwersja do systemu znak-moduł
        error = sm_number[N-1] == 0;                 // Sprawdź czy wystąpiło przepełnienie
    end
    else begin                         
        sm_number = u2_number;         // Liczba dodatnia, już w reprezentacji SM
        error = 0;                     // Wyczyść flagę błędu
    end
end

endmodule
