/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module negation_rtl(i_argA, o_result, error);
  wire _0_;
  wire _1_;
  wire _2_;
  output error;
  input [3:0] i_argA;
  output [3:0] o_result;
  assign _0_ = i_argA[1] | i_argA[0];
  assign _1_ = i_argA[2] | _0_;
  assign _2_ = ~_1_;
  assign error = i_argA[3] & _2_;
  assign o_result[1] = i_argA[1] ^ i_argA[0];
  assign o_result[2] = i_argA[2] ^ _0_;
  assign o_result[3] = i_argA[3] ^ _1_;
  assign o_result[0] = i_argA[0];
endmodule
