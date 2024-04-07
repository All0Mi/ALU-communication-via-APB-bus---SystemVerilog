`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/register.sv"
`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/u2_to_sm.sv"
`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/mux_4to1.sv"
`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/left_shift.sv"
`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/compare.sv"
`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/bit_change.sv"

module exe_unit_w26 #(parameter N=2, parameter M=8)(
    input logic [N-1:0] i_oper,
    input logic [M-1:0] i_argA,
    input logic [M-1:0] i_argB,
    input logic i_clk,
    input logic i_rsn,
    output logic [M-1:0] o_result,
    output logic [4-1:0] o_status
);

  logic err_conversion;
  logic err_left_shift;
  logic err_bit_change;
  logic [M-1:0] out_conversion;
  logic [M-1:0] out_shift;
  logic [M-1:0] out_bit_change;
  logic [M-1:0] out_compare;
  logic [M-1:0] out_mux;

  u2_to_sm #(M) conversion (
    .u2_number(i_argA),
    .sm_number(out_conversion),
    .error(err_conversion)
  );

  left_shift #(M) shift (
    .A(i_argA),
    .B(i_argB),
    .result(out_shift),
    .error(err_left_shift)
  );

  bit_change #(M) bit_change (
    .A(i_argA),
    .B(i_argB),
    .result(out_bit_change),
    .error(err_bit_change)
  );

  compare #(M) compare (
    .A(i_argA),
    .B(i_argB),
    .result(out_compare)
  );

  mux_4to1 #(M) mux (
    .in0(out_conversion),   //00
    .in1(out_shift),        //01
    .in2(out_bit_change),   //11
    .in3(out_compare),      //10
    .sel(i_oper),
    .out(out_mux)
  );

  register #(M) register (
    .clk(i_clk),
    .reset(i_rsn),
    .in(out_mux),
    .out(o_result)
  );


  logic [4-1:0] info;

  register #(4) status_register (
    .clk(i_clk),
    .reset(i_rsn),
    .in(info),
    .out(o_status)
  );

  integer count, i;

  always_comb begin
      count = 0;

      for( i = 0; i < M; i=i+1) 
      begin
        if(o_result[i] == 1) begin
          count = count + 1;
        end
      end

      info[0] = err_left_shift || err_bit_change;   // Błędy ogólne
      info[1] = (count%2 == 0);                     // Parzysta liczba jedynek
      info[2] = (o_result == {M{1'b1}});            // Same jedynki
      info[3] = err_conversion;                     // Błąd przepełnienia
  end

endmodule
