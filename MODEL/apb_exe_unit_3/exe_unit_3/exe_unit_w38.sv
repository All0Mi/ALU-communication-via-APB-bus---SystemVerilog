`include "./MODEL/apb_exe_unit_3/exe_unit_3/include.sv"
  
module exe_unit_w38 #(parameter M=8, parameter N=2)(i_op, i_argA, i_argB, i_clk, i_reset, o_result, o_stat);
	input logic [N-1:0] i_op; //wybiera operacje - MUX
	input logic [M-1:0] i_argA; //M-bitowe wejscie A
	input logic [M-1:0] i_argB; //M-bitowe wejscie B
	input logic i_reset; //reset
	input logic i_clk; //zegar
	output logic [M-1:0] o_result; //wyjscie
	output logic [3:0] o_stat; //wyjscie dla bledow


    //sygnaly wewnetrzne
    logic [M-1:0] s_out_set; //bit_set
    logic [M-1:0] s_out_shift; //bit_shift
    logic [M-1:0] s_out_comparator; //comparator
    logic [M-1:0] s_out_changer; //u2_to_sm

    logic [M-1:0] s_oper_mux; //wyjscie z muxa, operacje
    logic s_ERROR_set; //ERROR dla bit_set
    logic s_ERROR_shift; //ERROR dla bit_shift
    logic s_ERROR_change; //ERROR dla u2_to_sm
    logic [3:0] possible_errors; //wyjscie dla wszelakich znacznikow

    //Dolaczanie modulow:
    bit_set     #(.M(M))   setter    
    (.i_argA(i_argA),
     .i_argB(i_argB),
     .o_y(s_out_set),
     .ERROR(s_ERROR_set));

    bit_shift #(.M(M)) shifter 
    (.i_argA(i_argA),
     .i_argB(i_argB),
     .o_y(s_out_shift),
     .ERROR(s_ERROR_shift));

    comparator #(.M(M)) comparator 
    (.i_argA(i_argA),
    .i_argB(i_argB),
    .o_y(s_out_comparator));

    u2_to_sm #(.M(M)) changer 
    (.u2(i_argA),
     .sm(s_out_changer),
     .ERROR(s_ERROR_change)
     );

    MUX #(.M(M), .N(N)) MUX (.SET(s_out_set),
      .SHIFT(s_out_shift),
      .COMPARATOR(s_out_comparator),
      .CHANGER(s_out_changer),
      .testcase(i_op),
      .modul(s_oper_mux)
    );

    regg #(M) register (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_in(s_oper_mux),
        .o_out(o_result)
    );

     regg #(4) register_error (
      .i_clk(i_clk),
      .i_reset(i_reset),
      .i_in(possible_errors),
      .o_out(o_stat)
     );

    integer counter, i; //helper w zliczaniu
	always_comb
begin
    counter = 0;
    for (i = 0; i < M; i = i + 1)
    begin 
        if (o_result[i] == 1) begin
            counter = counter + 1;
        end
    end 

    possible_errors[0] = (counter % 2 == 0); // EVEN
    possible_errors[1] = (&o_result); // ONES
    possible_errors[2] = s_ERROR_change; // OVERFLOW
    possible_errors[3] = s_ERROR_set || s_ERROR_shift; // ERROR
end

    
endmodule


