//`include "./modules/register.sv"
`include "%INCLUDE%"

module testbench;

  parameter N = 8;

  logic clk = 0; 
  logic reset = 0;
  logic [N-1:0] in_data;
  logic [N-1:0] out_data;

  register #(N) u_register (
    .clk(clk),
    .reset(reset),
    .in(in_data),
    .out(out_data)
  );

  // Generacja sygnału zegarowego
  always #5 clk = ~clk;

  initial begin

    $dumpfile("./testbench/sim/tb_register.vcd");
    $dumpvars(0, testbench);

    $display("Test modułu register (podgląd w GTKwave)\n"); 

    reset = 1;
    in_data = 'b10101010;

    #12 reset = 0;

    #10;

    reset = 1;

    #15;

    in_data = 'b11000101;

    
  end

  initial #100 $finish;

endmodule
