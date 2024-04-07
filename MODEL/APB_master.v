`timescale 1ns / 1ps

module APB_master #(
   parameter   SEL_WIDTH                  = 1,           // PSEL width - one bit for each slave
   parameter   ADDR_WIDTH                 = 32,          // address width
   parameter   DATA_WIDTH                 = 32           // data width
)(
   // AMBA 3 APB interface
   input  wire                            i_PCLK,
   input  wire                            i_PRESETn,
   output reg [ADDR_WIDTH-1:0]            o_PADDR,
   output reg [SEL_WIDTH-1:0]             o_PSEL,
   output reg                             o_PENABLE,
   output reg                             o_PWRITE,
   output reg [DATA_WIDTH-1:0]            o_PWDATA,
   input  wire                            i_PREADY,
   input  wire[DATA_WIDTH-1:0]            i_PRDATA,
   input  wire                            i_PSLVERR,

   // User interface
   input  wire                            i_enable,      // enable transaction
   input  wire                            i_wr,          // '1' - write, '0' - read
   input  wire[$clog2(SEL_WIDTH+1)-1:0]   i_slave_idx,   // index of a selected slave
   input  wire[ADDR_WIDTH-1:0]            i_addr,        // address
   input  wire[DATA_WIDTH-1:0]            i_data_w,      // data to write
   output reg [DATA_WIDTH-1:0]            o_data_r,      // read data
   output reg                             o_data_valid,  // read data valid
   output reg                             o_busy         // module busy flag
);

reg [1:0] state;

localparam [1:0] IDLE_STATE      = 2'h0;
localparam [1:0] SETUP_STATE     = 2'h1;
localparam [1:0] ACCESS_STATE    = 2'h2;

always @(posedge i_PCLK or negedge i_PRESETn) begin
   if (!i_PRESETn) begin
      o_PADDR                    <= 'h0;
      o_PSEL                     <= 'h0;
      o_PENABLE                  <= 1'b0;
      o_PWRITE                   <= 1'b0;
      o_PWDATA                   <= 'h0;
      o_data_r                   <= 'h0;
      o_data_valid               <= 1'b0;
      o_busy                     <= 1'b0;
      state                      <= IDLE_STATE;
   end
   else begin
      case (state)
         IDLE_STATE: begin
            o_PSEL               <= 'h0;
            o_PENABLE            <= 1'b0;
            o_data_valid         <= 1'b0;
            o_busy               <= 1'b0;
            if (i_enable) begin
               o_busy            <= 1'b1;
               state             <= SETUP_STATE;
            end
         end
         SETUP_STATE: begin
            o_PSEL               <= 'h0;
            o_PSEL[i_slave_idx]  <= 1'b1;
            o_PENABLE            <= 1'b0;
            o_PADDR              <= i_addr;
            o_PWRITE             <= i_wr;
            o_data_valid         <= 1'b0;
            if (i_wr)
               o_PWDATA          <= i_data_w;
            state                <= ACCESS_STATE;
         end
         ACCESS_STATE: begin
            o_PENABLE            <= 1'b1;
            if (i_PREADY) begin
               if (!i_wr & !i_PSLVERR) begin
                  o_data_r       <= i_PRDATA;
                  o_data_valid   <= 1'b1;
               end
               if (i_enable)
                  state          <= SETUP_STATE;
               else
                  state          <= IDLE_STATE;
            end
         end
         default:
            state                <= IDLE_STATE;
      endcase
   end
end

always @(*) begin
   if ((state == ACCESS_STATE) & i_PREADY & i_PSLVERR)
      $display("Warning! Detected PSLVERR high!");
end

endmodule
