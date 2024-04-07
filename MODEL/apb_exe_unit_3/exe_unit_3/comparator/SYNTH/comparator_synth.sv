/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module comparator_synth(i_argA, i_argB, o_y);
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
  input [7:0] i_argA;
  input [7:0] i_argB;
  output o_y;
  assign _00_ = i_argA[7] | ~(i_argB[7]);
  assign _01_ = i_argB[7] ^ i_argA[7];
  assign _02_ = i_argA[6] | ~(i_argB[6]);
  assign _03_ = ~((_02_ | _01_) & _00_);
  assign _04_ = i_argB[6] ^ i_argA[6];
  assign _05_ = ~(_04_ | _01_);
  assign _06_ = i_argA[5] | ~(i_argB[5]);
  assign _07_ = i_argB[5] ^ i_argA[5];
  assign _08_ = i_argA[4] | ~(i_argB[4]);
  assign _09_ = ~((_08_ | _07_) & _06_);
  assign _10_ = ~((_09_ & _05_) | _03_);
  assign _11_ = i_argB[4] ^ i_argA[4];
  assign _12_ = ~(_11_ | _07_);
  assign _13_ = ~(_12_ & _05_);
  assign _14_ = i_argA[3] | ~(i_argB[3]);
  assign _15_ = i_argB[3] ^ i_argA[3];
  assign _16_ = i_argA[2] | ~(i_argB[2]);
  assign _17_ = ~((_16_ | _15_) & _14_);
  assign _18_ = ~(i_argB[2] ^ i_argA[2]);
  assign _19_ = _18_ & ~(_15_);
  assign _20_ = i_argA[1] | ~(i_argB[1]);
  assign _21_ = i_argB[1] ^ i_argA[1];
  assign _22_ = i_argA[0] & ~(i_argB[0]);
  assign _23_ = ~((_22_ | _21_) & _20_);
  assign _24_ = ~((_23_ & _19_) | _17_);
  assign o_y = ~((_24_ | _13_) & _10_);
endmodule