/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module mux_4to1(in0, in1, in2, in3, sel, out);
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
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  input [7:0] in0;
  input [7:0] in1;
  input [7:0] in2;
  input [7:0] in3;
  output [7:0] out;
  input [1:0] sel;
  assign _00_ = ~(sel[1] | sel[0]);
  assign _01_ = sel[1] & ~(sel[0]);
  assign _02_ = sel[1] & sel[0];
  assign _03_ = ~((_02_ & in2[0]) | (_01_ & in3[0]));
  assign _04_ = sel[1] | ~(sel[0]);
  assign _05_ = in1[0] & ~(_04_);
  assign _06_ = _05_ | ~(_03_);
  assign out[0] = _00_ ? in0[0] : _06_;
  assign _07_ = ~((_02_ & in2[1]) | (_01_ & in3[1]));
  assign _08_ = in1[1] & ~(_04_);
  assign _09_ = _08_ | ~(_07_);
  assign out[1] = _00_ ? in0[1] : _09_;
  assign _10_ = ~((_02_ & in2[2]) | (_01_ & in3[2]));
  assign _11_ = in1[2] & ~(_04_);
  assign _12_ = _11_ | ~(_10_);
  assign out[2] = _00_ ? in0[2] : _12_;
  assign _13_ = ~((_02_ & in2[3]) | (_01_ & in3[3]));
  assign _14_ = in1[3] & ~(_04_);
  assign _15_ = _14_ | ~(_13_);
  assign out[3] = _00_ ? in0[3] : _15_;
  assign _16_ = ~((_02_ & in2[4]) | (_01_ & in3[4]));
  assign _17_ = in1[4] & ~(_04_);
  assign _18_ = _17_ | ~(_16_);
  assign out[4] = _00_ ? in0[4] : _18_;
  assign _19_ = ~((_02_ & in2[5]) | (_01_ & in3[5]));
  assign _20_ = in1[5] & ~(_04_);
  assign _21_ = _20_ | ~(_19_);
  assign out[5] = _00_ ? in0[5] : _21_;
  assign _22_ = ~((_02_ & in2[6]) | (_01_ & in3[6]));
  assign _23_ = in1[6] & ~(_04_);
  assign _24_ = _23_ | ~(_22_);
  assign out[6] = _00_ ? in0[6] : _24_;
  assign _25_ = ~((_02_ & in2[7]) | (_01_ & in3[7]));
  assign _26_ = in1[7] & ~(_04_);
  assign _27_ = _26_ | ~(_25_);
  assign out[7] = _00_ ? in0[7] : _27_;
endmodule
