`include "./MODEL/APB_controller.sv"
`include "./MODEL/apb_exe_unit_1/apb_exe_unit_1.sv"

// Komendy z poziomu sck-grupowy
// iverilog -g2005-sv -o ./TEST/VVP/tb_apb_controller.vvp ./TEST/tb_apb_controller.sv
// vvp ./TEST/VVP/tb_apb_controller.vvp   

module testbench;

  parameter SEL_WIDTH = 3;
  parameter ADDR_WIDTH = 2;
  parameter DATA_WIDTH = 8;
  parameter MEMORY_WIDTH = 14;

  logic i_PCLK = 0;

  logic i_PRESETn;
  logic [ADDR_WIDTH-1:0]  i_PADDR;
  logic [SEL_WIDTH-1:0]   i_PSEL;
  logic i_PENABLE;
  logic i_PWRITE;
  logic [DATA_WIDTH-1:0]  i_PWDATA;
  logic o_PREADY;
  logic [DATA_WIDTH-1:0]  o_PRDATA;
  logic o_PSLVERR;


    controller #( .SEL_WIDTH(SEL_WIDTH), 
    .ADDR_WIDTH(ADDR_WIDTH), 
    .DATA_WIDTH(DATA_WIDTH),
    .MEMORY_WIDTH(MEMORY_WIDTH)) cnt (
    .CLK(i_PCLK),
    .o_PRESETn(i_PRESETn),
    .o_PADDR(i_PADDR),
    .o_PSEL(i_PSEL),
    .o_PENABLE(i_PENABLE),
    .o_PWRITE(i_PWRITE),
    .o_PWDATA(i_PWDATA),
    .i_PREADY(o_PREADY),
    .i_PRDATA(o_PRDATA),
    .i_PSLVERR(o_PSLVERR)
    );

      apb_exe_unit_1 #(.SEL_WIDTH(SEL_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .SEL_BIT(1)) slave (
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



  always #1 i_PCLK = ~i_PCLK;


   initial begin

    $dumpfile("./TEST/VCD/tb_apb_controller.vcd");
    $dumpvars(0, testbench);


  end

  initial #150 $finish;

endmodule
