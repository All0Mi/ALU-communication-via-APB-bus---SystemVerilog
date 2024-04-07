`include "./MODEL/apb_exe_unit_3/apb_exe_unit_3.sv"


// Komendy z poziomu sck-grupowy
// iverilog -g2005-sv -o ./TEST/VVP/tb_apb_exe_unit_3.vvp ./TEST/tb_apb_exe_unit_3.sv
// vvp ./TEST/VVP/tb_apb_exe_unit_3.vvp   

module testbench;

  parameter SEL_WIDTH = 3;
  parameter ADDR_WIDTH = 2;
  parameter DATA_WIDTH = 8;

  logic i_PCLK = 0;                 
  logic i_PWRITE;
  logic i_PENABLE;                  
  logic i_PRESETn;                  
  logic [ADDR_WIDTH-1:0] i_PADDR;   
  logic [DATA_WIDTH-1:0] i_PWDATA;
  logic [SEL_WIDTH-1:0] i_PSEL;    

  logic o_PREADY;
  logic [DATA_WIDTH-1:0] o_PRDATA;
  logic [3:0] o_PSLVERR;

  always #1 i_PCLK = ~i_PCLK;

  apb_exe_unit_3 #(.SEL_WIDTH(SEL_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .SEL_BIT(3)) slave (
  .i_PCLK(i_PCLK), 
  .i_PWRITE(i_PWRITE), 
  .i_PENABLE(i_PENABLE), 
  .i_PRESETn(i_PRESETn),
  .i_PADDR(i_PADDR), 
  .i_PWDATA(i_PWDATA), 
  .i_PSEL(i_PSEL),

  .o_PREADY(o_PREADY),
  .o_PRDATA(o_PRDATA),
  .o_PSLVERR(o_PSLVERR)
  );

   initial begin

    $dumpfile("./TEST/VCD/tb_apb_exe_unit_3.vcd");
    $dumpvars(0, testbench);

    // Inicjalizacja

    i_PWRITE = 1;
    i_PRESETn = 0;
    i_PENABLE = 'b0;

    i_PADDR = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 'b0;

    #6;
    i_PRESETn = 0;
    i_PENABLE = 'b0;

    #6;
    i_PRESETn = 1;


    // Przesun 1010 o 1 bit w lewo z zachowaniem znaku
    #6;
    i_PWRITE = 1;
    i_PADDR = 'b01;
    i_PSEL = 3'b001;
    i_PWDATA = 'b00011010;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Odczyt
    #6;
    i_PWRITE = 0;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b001;
    i_PADDR = 'b00;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Przekonwertuj 1010 na ZM
    #6;
    i_PWRITE = 1;
    i_PADDR = 'b00;
    i_PSEL = 3'b001;
    i_PWDATA = 'b00101010;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Odczyt
    #6;
    i_PWRITE = 0;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b001;
    i_PADDR = 'b00;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    
    // Przesun 1010 o 1 bit w lewo z zachowaniem znaku
    #6;
    i_PWRITE = 1;
    i_PADDR = 'b11;
    i_PSEL = 3'b001;
    i_PWDATA = 'b00001010;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Odczyt
    #6;
    i_PWRITE = 0;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b001;
    i_PADDR = 'b00;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Przesun 1010 o 1 bit w lewo z zachowaniem znaku
    #6;
    i_PWRITE = 1;
    i_PADDR = 'b10;
    i_PSEL = 3'b001;
    i_PWDATA = 'b00110010;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

    // Odczyt
    #6;
    i_PWRITE = 0;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b001;
    i_PADDR = 'b00;

    #2;
    i_PENABLE = 'b1;

    #8;
    i_PENABLE = 'b0;
    i_PWDATA = 'b0;
    i_PSEL = 3'b000;
    i_PADDR = 'b00;

  end

  initial #150 $finish;

endmodule
