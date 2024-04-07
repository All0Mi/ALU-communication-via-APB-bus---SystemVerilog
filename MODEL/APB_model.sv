`include "./apb_exe_unit_1/apb_exe_unit_1.sv"
`include "./apb_exe_unit_2/apb_exe_unit_2.sv"
`include "./apb_exe_unit_3/apb_exe_unit_3.sv"
`include "./APB_arbiter.sv"
`include "./APB_bus.sv"
`include "./APB_master.sv"

module model #(
    parameter SEL_WIDTH = 3,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    // Slave 1
    logic s_bus_clock_1,
    logic s_bus_write_1,
    logic [ADDR_WIDTH-1:0] s_bus_addr_1,
    logic [DATA_WIDTH-1:0] s_bus_data_1,
    logic s_bus_enable_1,
    logic s_bus_reset_1,
    logic [SEL_WIDTH-1:0] s_bus_sel_1,
    logic s_slave_ready_1,
    logic [DATA_WIDTH-1:0] s_slave_data_1,
    logic s_slave_error_1,

    // TODO: Slave 2 and Slave 3 declarations

    // Arbiter
    logic s_arbiter_ready,
    logic [DATA_WIDTH-1:0] s_arbiter_data,
    logic s_arbiter_error,

    // Bus
    logic [ADDR_WIDTH-1:0] s_bus_addr,
    logic [SEL_WIDTH-1:0] s_bus_sel,
    logic s_bus_write,
    logic [DATA_WIDTH-1:0] s_bus_data,
    logic s_bus_clock,
    logic s_bus_enable,
    logic s_bus_reset
);

//slave 1
slave_module1 #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) slave1 (
    .i_PCLK(s_bus_clock_1),
    .i_PWRITE(s_bus_write_1),
    .i_PADDR(s_bus_addr_1),
    .i_PWDATA(s_bus_data_1),
    .i_PENABLE(s_bus_enable_1),
    .i_PRESETn(s_bus_reset_1),
    .i_PSEL1(s_bus_sel_1),
    .o_PREADY(s_slave_ready_1),
    .o_PRDATA(s_slave_data_1),
    .o_PSLVERR(s_slave_error_1)
);

// TODO: Slave2
//TODO: Slave3

// Arbiter
apb_arbiter #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) arbiter (
    // Slave 1
    .i_PREADY_1(s_slave_ready_1),
    .i_PRDATA_1(s_slave_data_1),
    .i_PSLVERR_1(s_slave_error_1),

    // TODO: Slave2
    //TODO: Slave3

    // Controller (Master)
    .o_controller_ready(s_arbiter_ready),
    .o_controller_data(s_arbiter_data),
    .o_controller_error(s_arbiter_error)
);

// controller
apb_controller #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) controller (
    .PCLK(s_bus_clock_1),
    .PADDR(s_bus_addr_1),
    .PSEL1(s_bus_sel_1),
    .PENABLE(s_bus_enable_1),
    .PWDATA(s_bus_data_1),
    .PWRITE(s_bus_write_1)

);

// bus APB
bus #(SEL_WIDTH, ADDR_WIDTH, DATA_WIDTH) bus (
    .o_PCLK(s_bus_clock),
    .o_PSEL(s_bus_sel),
    .o_PENABLE(s_bus_enable),
    .o_PADDR(s_bus_addr),
    .o_PWRITE(s_bus_write),
    .o_PWDATA(s_bus_data),

    // arbiter
    .i_PREADY_ar(s_arbiter_ready),
    .i_PRDATA_ar(s_arbiter_data),
    .i_PSLVERR_ar(s_arbiter_error),

    // slave1
    .i_ready_s1(s_slave_ready_1),
    .i_data_s1(s_slave_data_1),
    .i_error_s1(s_slave_error_1),

    //TODO: slave2
    //TODO: slave 3
);

endmodule
