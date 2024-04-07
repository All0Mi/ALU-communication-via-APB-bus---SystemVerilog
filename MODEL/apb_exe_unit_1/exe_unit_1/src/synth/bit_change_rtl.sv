/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module bit_change(A, B, result, error);
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
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  wire _38_;
  input [7:0] A;
  input [7:0] B;
  output error;
  output [7:0] result;
  assign _00_ = B[7] | B[6];
  assign _01_ = B[5] | B[4];
  assign _02_ = _01_ | _00_;
  assign _03_ = B[2] | ~(B[3]);
  assign _04_ = B[1] | B[0];
  assign _05_ = _04_ | _03_;
  assign _06_ = ~((_05_ & B[3]) | _02_);
  assign error = ~((_05_ | _02_) & _06_);
  assign _07_ = ~A[0];
  assign _08_ = _02_ | B[0];
  assign _09_ = _08_ | B[1];
  assign _10_ = _09_ | B[2];
  assign _11_ = _10_ | B[3];
  assign result[0] = ~((_11_ | error) & _07_);
  assign _12_ = ~A[1];
  assign _13_ = _02_ | ~(B[0]);
  assign _14_ = _13_ | B[1];
  assign _15_ = _14_ | B[2];
  assign _16_ = _15_ | B[3];
  assign result[1] = ~((_16_ | error) & _12_);
  assign _17_ = ~A[2];
  assign _18_ = ~B[1];
  assign _19_ = _08_ | _18_;
  assign _20_ = _19_ | B[2];
  assign _21_ = _20_ | B[3];
  assign result[2] = ~((_21_ | error) & _17_);
  assign _22_ = ~A[3];
  assign _23_ = _13_ | _18_;
  assign _24_ = _23_ | B[2];
  assign _25_ = _24_ | B[3];
  assign result[3] = ~((_25_ | error) & _22_);
  assign _26_ = ~A[4];
  assign _27_ = ~B[2];
  assign _28_ = _09_ | _27_;
  assign _29_ = _28_ | B[3];
  assign result[4] = ~((_29_ | error) & _26_);
  assign _30_ = ~A[5];
  assign _31_ = _14_ | _27_;
  assign _32_ = _31_ | B[3];
  assign result[5] = ~((_32_ | error) & _30_);
  assign _33_ = ~A[6];
  assign _34_ = _19_ | _27_;
  assign _35_ = _34_ | B[3];
  assign result[6] = ~((_35_ | error) & _33_);
  assign _36_ = ~A[7];
  assign _37_ = _23_ | _27_;
  assign _38_ = _37_ | B[3];
  assign result[7] = ~((_38_ | error) & _36_);
endmodule