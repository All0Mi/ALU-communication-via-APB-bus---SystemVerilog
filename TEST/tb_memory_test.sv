`include "./MODEL/Memory_model.v"

// Komendy z poziomu sck-grupowy
// iverilog -g2005-sv -o ./TEST/VVP/tb_memory_test.vvp ./TEST/tb_memory_test.sv
// vvp ./TEST/VVP/tb_memory_test.vvp   

module testbench;

   parameter   ADDR_WIDTH        = 0;             // memory address size – memory depth = 2^ADDR_WIDTH
   parameter   DATA_WIDTH        = 14;             // memory data width
   parameter   MEMORY_FILE       = "mem.data";     // file containing dump of instruction and data memory
   parameter   MEMORY_DUMP_FILE  = "mem_dump.data"; // file containing dump of instruction and data memory

   logic i_clk = 0;
   logic i_en = 0;
   logic i_wr = 0;

   logic i_dump = 0;  

    logic[ADDR_WIDTH-1:0]   i_addr;           // address bus
    logic[DATA_WIDTH-1:0]   i_data_w;         // write data bus
    logic[DATA_WIDTH-1:0]   o_data_r;  

    logic[ADDR_WIDTH-1:0] i_write_addr;

   always #1 i_clk = ~i_clk;

 Memory_model #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .MEMORY_FILE(MEMORY_FILE), .MEMORY_DUMP_FILE(MEMORY_DUMP_FILE)) memory(
    .i_clk(i_clk), .i_en(i_en), .i_wr(i_wr), .i_dump(i_dump), .i_addr(i_addr), .i_data_w(i_data_w), .o_data_r(o_data_r), .i_write_addr(i_write_addr)

 );

  initial begin

    $dumpfile("./TEST/VCD/tb_memory_test.vcd");
    $dumpvars(0, testbench);

    i_en = 1;
    i_wr = 0;
    i_addr = 'b0;
    #6;
    i_write_addr = 'b0;
    i_data_w = 'b01010100101010;
    #2;
    i_en = 1;
    i_wr = 1;
    #6;
    i_en = 0;
    i_dump = 1;
    #7;
    i_en = 1;
    i_wr = 0;
    i_dump = 0;
    i_addr = 'b1;
    #6;
  end

  initial #100 $finish;
    
endmodule
