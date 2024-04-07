`include "./APB_arbiter.sv"
`include "./APB_master.sv"
`include "./Memory_model.sv"

module bus #(
    parameter SEL_WIDTH = 3,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    // Wejścia
    input logic i_CLK,
    input logic i_RESETn

    logic s_ready;
    logic s_error;
    logic [DATA_WIDTH-1:0] s_data;
    logic [SEL_WIDTH-1:0] s_sel;
);

    APB_master #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) master (
        .i_PCLK(i_CLK),
        .i_PRESETn(i_RESETn),
        .i_PREADY(s_ready),
        .i_PSLVERR(s_error),
        .i_PRDATA(s_data)
    );

    memory_model #(ADDR_WIDTH, DATA_WIDTH) memory (
        .i_CLK(i_CLK),
        .i_RESETn(i_RESETn),
        .i_MUX_SEL(s_sel),
        .i_MUX_DATA(s_data),
        .i_MUX_READY(s_ready)
    );

endmodule
