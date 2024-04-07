/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module changecode_rtl(i_argA, o_result, error);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  output error;
  input [3:0] i_argA;
  output [3:0] o_result;
  assign _00_ = ~i_argA[2];
  assign _01_ = ~i_argA[3];
  assign _02_ = i_argA[1] & i_argA[0];
  assign _03_ = ~_02_;
  assign _04_ = i_argA[1] | i_argA[0];
  assign _05_ = ~_04_;
  assign _06_ = i_argA[3] & _04_;
  assign _07_ = _03_ & _06_;
  assign _08_ = i_argA[1] & _01_;
  assign o_result[1] = _07_ | _08_;
  assign o_result[2] = i_argA[2] ^ _06_;
  assign _09_ = _00_ & i_argA[3];
  assign error = _05_ & _09_;
  assign { o_result[3], o_result[0] } = { i_argA[3], i_argA[0] };
endmodule