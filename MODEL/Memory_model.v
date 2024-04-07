`timescale 1ns / 1ps

module Memory_model #(
   parameter   ADDR_WIDTH        = 16,             // memory address size – memory depth = 2^ADDR_WIDTH
   parameter   DATA_WIDTH        = 14,             // memory data width
   parameter   MEMORY_FILE       = "mem.data",     // file containing dump of instruction and data memory
   parameter   MEMORY_DUMP_FILE  = "mem_dump.data" // file containing dump of instruction and data memory
)(
   input  wire                   i_clk,            // clock signal
   input  wire                   i_en,             // enable
   input  wire                   i_wr,             // '1' - write, '0' - read

   input  wire[ADDR_WIDTH-1:0]   i_addr,           // address bus
   input  wire[DATA_WIDTH-1:0]   i_data_w,         // write data bus
   output reg [DATA_WIDTH-1:0]   o_data_r,         // read data bus
   
   input  wire                   i_dump,            // '1' to dump memory contents to MEMORY_DUMP_FILE

   input  wire[ADDR_WIDTH-1:0]   i_write_addr     // address bus
);

reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];
reg [DATA_WIDTH-1:0] memory_write [0:(1<<ADDR_WIDTH)-1];

initial begin
   $readmemb(MEMORY_FILE, memory); // binary
end

always @(posedge i_clk) begin
   if (i_en) 
   begin
      if (!i_wr)
         o_data_r         <= memory[i_addr];
      else
         memory_write[i_write_addr]   <= i_data_w;
   end 
   if (i_dump)
      $writememb(MEMORY_DUMP_FILE, memory_write); // binary
end 

endmodule
