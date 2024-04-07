//`include "./modules/mux_4to1.sv"
`include "%INCLUDE%"

module testbench;

  parameter N = 8;

  reg [N-1:0] in0_data, in1_data, in2_data, in3_data;
  reg [1:0] sel;
  wire [N-1:0] out;

  mux_4to1 #(N) uut (
    .in0(in0_data),
    .in1(in1_data),
    .in2(in2_data),
    .in3(in3_data),
    .sel(sel),
    .out(out)
  );

  initial begin

    $dumpfile("./testbench/sim/tb_mux_4to1.vcd");
    $dumpvars(0, testbench);

    in0_data = 8'b10101010;
    in1_data = 8'b11001100;
    in2_data = 8'b11110000;
    in3_data = 8'b00001111;
    sel = 2'b00;

    $display("Test modułu mux_4to1\n"); 

    $display("in0: %b\nin1: %b\nin2: %b\nin3: %b\n", 
              in0_data, in1_data, in2_data, in3_data);

    #10;
    $display("sel: %b\tout: %b", sel, out);
    sel = 2'b01;
    #10;
    $display("sel: %b\tout: %b", sel, out);
    sel = 2'b10;
    #10;
    $display("sel: %b\tout: %b", sel, out);
    sel = 2'b11;
    #10;
    $display("sel: %b\tout: %b\n", sel, out);
    #10;
    
    $finish;
  end

endmodule