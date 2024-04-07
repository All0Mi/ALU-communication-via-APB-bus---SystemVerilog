module u2_to_sm #(parameter M=8)(u2, sm, ERROR);

input logic[M-1:0] u2; //M-bitowe wejscie
output logic[M-1:0] sm; //M-bitowe wyjscie (po zamianie z U2 na ZNAK-MODUL)
output logic ERROR; //blad

//changing function
always@(*) begin
    if(u2[M-1] == 1)
    begin
        sm = {1'b1, {~u2[M-2:0]}} + 1;
        ERROR = sm[M-1] == 0; //szukanie bledu typu OVERFLOW
    end
    else 
    begin
        sm = u2;
        ERROR = 0; //zerowanie bledu
    end
end

endmodule