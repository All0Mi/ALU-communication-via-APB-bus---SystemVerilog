`include "./MODEL/APB_master.v"
`include "./MODEL/Memory_model.v"

// iverilog -g2005-sv -o ./TEST/VVP/APB_controller.vvp ./MODEL/APB_controller.sv

module controller #(
    parameter SEL_WIDTH = 3,
    parameter ADDR_WIDTH = 2,
    parameter DATA_WIDTH = 16,
    parameter MEMORY_WIDTH = 14
)(
    input   logic                   CLK,
    output  logic                   o_PRESETn,   /// reset OUTPUT
    output  logic [ADDR_WIDTH-1:0]  o_PADDR,
    output  logic [SEL_WIDTH-1:0]   o_PSEL,
    output  logic                   o_PENABLE,
    output  logic                   o_PWRITE,
    output  logic [DATA_WIDTH-1:0]  o_PWDATA,
    input   logic                   i_PREADY,
    input   logic [DATA_WIDTH-1:0]  i_PRDATA,
    input   logic                   i_PSLVERR
);

    localparam [2:0] READ_STATE      = 3'h0;
    localparam [2:0] PUSH_STATE      = 3'h1;
    localparam [2:0] SAVE_STATE      = 3'h2;
    localparam [2:0] WAIT_STATE      = 3'h3;
    localparam [2:0] ANSW_STATE      = 3'h4;
    localparam [2:0] END_STATE       = 3'h5;
    localparam [2:0] DUMP_STATE      = 3'h6;
    localparam [2:0] HOLD_STATE      = 3'h7;

    reg [2:0] state = READ_STATE;

    logic busy;
    logic i_PRESETn;   /// reset OUTPUT

    APB_master #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) master (
    // AMBA 3 ABP interface
    .i_PCLK(CLK),
    .i_PRESETn(i_PRESETn),
    .o_PADDR(o_PADDR),
    .o_PSEL(o_PSEL),
    .o_PENABLE(o_PENABLE),
    .o_PWRITE(o_PWRITE),
    .o_PWDATA(o_PWDATA),
    .i_PREADY(i_PREADY),
    .i_PRDATA(i_PRDATA),
    .i_PSLVERR(i_PSLVERR),
    // User interface
    .i_enable(P_enable),
    .i_wr(P_wr),
    .i_slave_idx(P_slave_idx),
    .i_addr(P_addr),
    .i_data_w(P_data_w),
    .o_data_r(P_data_r),
    .o_data_valid(P_data_valid),
    .o_busy(busy)
    );

    logic P_enable;
    logic P_wr;
    logic [2-1:0]          P_slave_idx;
    logic [ADDR_WIDTH-1:0] P_addr;
    logic [DATA_WIDTH-1:0] P_data_w;
    logic [DATA_WIDTH-1:0] P_data_r;
    logic P_data_valid;

    Memory_model #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(MEMORY_WIDTH)) memory (
        .i_clk(CLK),
        .i_en(i_en),
        .i_wr(i_wr),
        .i_addr(mem_addr),
        .i_data_w(i_data_w),
        .o_data_r(o_data_r),
        .i_dump(i_dump),
        .i_write_addr(write_addr)
    );

    logic [ADDR_WIDTH-1:0] mem_addr = 0; 
    logic [ADDR_WIDTH-1:0] write_addr = 0;
    logic [MEMORY_WIDTH-1:0] o_data_r;
    logic [MEMORY_WIDTH-1:0] i_data_w;

    logic next = 1'b1;
    logic i_en = 1;
    logic i_wr = 0;
    logic i_dump = 0;

    logic s_save = 0;
    logic s_reset = 1;

    always @(posedge CLK) begin

    case (state)
        READ_STATE: begin
            i_wr <= 0;
            i_en <= 1;
            i_dump <= 0;
            state <= PUSH_STATE;
        end

        PUSH_STATE: begin
            i_en <= 0;
            i_wr <= 0;

            {P_slave_idx, P_addr, P_data_w, s_save, s_reset, P_wr} <= {o_data_r, 1'b1};

            o_PRESETn <= s_reset;
            i_PRESETn <= s_reset;


            if (o_data_r == 0) begin
                state <= HOLD_STATE;
            end else begin
                P_enable <= 'b1;
                state <= WAIT_STATE;
            end
        end

        WAIT_STATE: begin
            if(i_PREADY) begin
                {P_slave_idx, P_addr, P_data_w, P_wr} <= 'b0;
                o_PRESETn <= 'b0;
                i_PRESETn <= 'b0;
                P_enable = 'b0;
                if(s_save) begin
                    state <= ANSW_STATE;
                end else begin
                    state <= END_STATE;
                end
            end
        end

        ANSW_STATE: begin
                P_wr <= 1'b0;
                o_PRESETn <= s_reset;
                i_PRESETn <= s_reset;
                P_enable <= 'b1;
                state <= SAVE_STATE;
        end

        SAVE_STATE: begin
            if(i_PREADY) begin
                {P_slave_idx, P_addr, P_data_w, P_wr} <= 'b0;
                o_PRESETn <= 'b0;
                i_PRESETn <= 'b0;
                P_enable <= 'b0;

                i_wr <= 1;

                i_data_w <= i_PRDATA;
                
                i_en <= 1;

                state <= END_STATE;

            end
        end

        END_STATE: begin
            mem_addr <= mem_addr + 1;
            write_addr <= write_addr + 1;
            state = READ_STATE;

            // i_wr <= 0;
            // i_en <= 0;
            // i_dump <= 1;
        end

        HOLD_STATE: begin
            i_wr <= 0;
            i_en <= 0;
            i_dump = 1;
        end
    endcase

    
    end

endmodule
