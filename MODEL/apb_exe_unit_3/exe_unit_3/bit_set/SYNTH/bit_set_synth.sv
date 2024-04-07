/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module bit_set_synth(i_argA, i_argB, ERROR, o_y);
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
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  output ERROR;
  input [7:0] i_argA;
  input [7:0] i_argB;
  output [7:0] o_y;
  assign _00_ = ~(i_argB[7] | i_argB[6]);
  assign _01_ = i_argB[5] | i_argB[4];
  assign _02_ = _01_ | ~(_00_);
  assign _03_ = i_argB[3] | ~(i_argB[2]);
  assign _04_ = ~(i_argB[1] & i_argB[0]);
  assign _05_ = _04_ | _03_;
  assign _06_ = _05_ | _02_;
  assign _07_ = i_argB[2] | i_argB[3];
  assign _08_ = ~((_07_ & _03_) | _02_);
  assign ERROR = ~(_08_ & _06_);
  assign _09_ = ~i_argA[0];
  assign _10_ = i_argB[1] | i_argB[0];
  assign _11_ = _10_ | _07_;
  assign _12_ = _11_ | _02_;
  assign o_y[0] = ~((_12_ | ERROR) & _09_);
  assign _13_ = ~i_argA[1];
  assign _14_ = i_argB[1] | ~(i_argB[0]);
  assign _15_ = _14_ | _07_;
  assign _16_ = _15_ | _02_;
  assign o_y[1] = ~((_16_ | ERROR) & _13_);
  assign _17_ = ~i_argA[2];
  assign _18_ = i_argB[0] | ~(i_argB[1]);
  assign _19_ = _18_ | _07_;
  assign _20_ = _19_ | _02_;
  assign o_y[2] = ~((_20_ | ERROR) & _17_);
  assign _21_ = ~i_argA[3];
  assign _22_ = _07_ | _04_;
  assign _23_ = _22_ | _02_;
  assign o_y[3] = ~((_23_ | ERROR) & _21_);
  assign _24_ = ~i_argA[4];
  assign _25_ = _10_ | _03_;
  assign _26_ = _25_ | _02_;
  assign o_y[4] = ~((_26_ | ERROR) & _24_);
  assign _27_ = ~i_argA[5];
  assign _28_ = _14_ | _03_;
  assign _29_ = _28_ | _02_;
  assign o_y[5] = ~((_29_ | ERROR) & _27_);
  assign _30_ = ~i_argA[6];
  assign _31_ = _18_ | _03_;
  assign _32_ = _31_ | _02_;
  assign o_y[6] = ~((_32_ | ERROR) & _30_);
  assign _33_ = ~i_argA[7];
  assign o_y[7] = ~((ERROR | _06_) & _33_);
endmodule