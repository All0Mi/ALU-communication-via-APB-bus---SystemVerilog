module bit_set #(parameter M=8)(i_argA, i_argB, ERROR, o_y);
    
    //inputs & outputs
    input logic [M-1:0] i_argA; //M-bitowe wejscie A
    input logic [M-1:0] i_argB; //M-bitowe wejscie B
    output logic ERROR; // wyjscie bledu
    output logic [M-1:0] o_y; //wejscie zmienionego A

    //function
        always@(*) begin
            if(i_argB < 0 || i_argB >= M)
            begin
                ERROR = 1; //Blad jezeli B jest poza zakresem
                o_y = i_argA; //Wtedy A jest bez zmian
            end
            else
            begin
                ERROR = 0; //Blad sie 'zeruje'
                o_y= i_argA;
                o_y[i_argB] = 1;
            end
        end

endmodule