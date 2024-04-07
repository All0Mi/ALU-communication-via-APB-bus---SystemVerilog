//`include "./modules/exe_unit_w26.sv"
`include "%INCLUDE%"

module testbench;

  parameter N = 2;
  parameter M = 8;

  logic [N-1:0] oper = 'b0;
  logic [M-1:0] A    = 'b00001010;
  logic [M-1:0] B    = 'b00000001;
  logic clk = 0;
  logic rst = 1;
  logic [M-1:0] result;
  logic [4-1:0] status;

  exe_unit_w26 #(.N(N), .M(M)) unit (
    .i_oper(oper),
    .i_argA(A),
    .i_argB(B),
    .i_clk(clk),
    .i_rsn(rst),
    .o_result(result),
    .o_status(status)
  );

  // Generacja sygnału zegarowego
  always #1 clk = ~clk;

  initial begin

    $dumpfile("./testbench/sim/tb_exe_unit_w26.vcd");
    $dumpvars(0, testbench);

    $display("Test modułu exe_unit_w26\n");

    // Reset w celu inicjalizacji
    rst = 0;
    #2;
    rst = 1;

   /*     Konwersja     */
    oper = 2'b00;
    A = 8'b01111000;  // Liczba dodatnia
    #4;

    A =  8'b11111000; // Liczba ujemna 
    #4;

    A = 8'b10000000; // Spełnienie warunku przepełnienia
    #8;


    /*      Przesunięcie     */
    oper = 2'b01;
    A = 8'b00111100; // Przesunięcie liczby dodatniej
    B = 2;
    #4;

    A = 8'b10111100; // Przesunięcie liczby ujemnej
    B = 2;
    #4;


    A = 8'b00111100; // Błąd B < 0
    B = -2;
    #8;


    /*      Zmiana bitu     */
    oper = 2'b11;
    A = 8'b00111100;  // Zmiana pierwszego bitu
    B = 0;
    #4;

    A = 8'b00111100;  // B < 0
    B = -2;
    #4;

    A = 8'b11111110;  // Test na parzystość bitów i sygnał składający się z samych jedynek
    B = 0;
    #8;

    
    /*     Porównanie (A < B) */
    oper = 2'b10;
    A = 8'b00011100;
    B = 8'b00111100;
    #4;

    A = 8'b01011100;
    B = 8'b00111100;
    #4;
    
    A = 8'b11011100;
    B = 8'b00111100;
    #4;


  end

  initial #100 $finish;

endmodule
