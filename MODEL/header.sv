`ifndef APB_MODEL_DEF

`define APB_MODEL_DEF

`include "./apb_exe_unit_1/apb_exe_unit_1.sv"
`include "./apb_exe_unit_2/apb_exe_unit_2.sv"
`include "./apb_exe_unit_3/apb_exe_unit_3.sv"
`include "./APB_arbiter.sv"
`include "./APB_bus.sv"
`include "./APB_master.sv"

`define SEL_WIDTH 3
`define ADDR_WIDTH 32
`define DATA_WIDTH 32

  
`endif