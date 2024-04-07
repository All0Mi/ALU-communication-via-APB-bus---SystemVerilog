`include "./MODEL/apb_exe_unit_1/exe_unit_1/src/modules/exe_unit_w26.sv"

// iverilog -g2005-sv -o ./TEST/VVP/apb_exe_unit_1.vvp ./MODEL/apb_exe_unit_1/apb_exe_unit_1.sv

module apb_exe_unit_1 #(
    parameter SEL_WIDTH = 3,
    parameter ADDR_WIDTH = 2,
    parameter DATA_WIDTH = 32,
    parameter SEL_BIT = 1
)(
    input logic i_PCLK,                     
    input logic i_PWRITE,
    input logic i_PENABLE,                  
    input logic i_PRESETn,  
    input logic [ADDR_WIDTH-1:0] i_PADDR,   
    input logic [DATA_WIDTH-1:0] i_PWDATA,     
    input logic [SEL_WIDTH-1:0] i_PSEL,
       
    output logic o_PREADY,
    output logic o_PSLVERR,
    output logic [DATA_WIDTH-1:0] o_PRDATA
);

    logic s_pslverr;

    logic [DATA_WIDTH/2-1:0] s_result;
    logic [ADDR_WIDTH-1:0] s_PADDR;   
    logic [DATA_WIDTH-1:0] s_PWDATA;     


    exe_unit_w26 #(.N(ADDR_WIDTH), .M(DATA_WIDTH/2)) slave (.i_clk(i_PCLK), .i_oper(s_PADDR), .i_argA(s_PWDATA[DATA_WIDTH/2-1:0]), .i_argB(s_PWDATA[DATA_WIDTH-1:DATA_WIDTH/2]), .o_result(s_result));

    always_ff @(posedge i_PCLK or negedge i_PRESETn) begin
        s_pslverr <= 0;
        if (!i_PRESETn) begin // RESET
            o_PREADY <= 1'b0;
            o_PRDATA <= 'b0;
            o_PSLVERR <= 1'b0;
        end else if (i_PENABLE && i_PSEL[SEL_BIT-1] == 1 && i_PWRITE == 1) begin // ZAPIS (MASTER -> SLAVE)
            s_PADDR <= i_PADDR;
            s_PWDATA <= i_PWDATA;
            o_PREADY <= 1'b1;
            o_PSLVERR <= s_pslverr;
        end else if (i_PENABLE && i_PSEL[SEL_BIT-1] == 1 && i_PWRITE == 0) begin // ODCZYT (SLAVE -> MASTER)
            o_PREADY <= 1'b1;
            o_PRDATA <= {{(DATA_WIDTH/2){1'b0}},{s_result}};
            o_PSLVERR <= s_pslverr;
        end else begin
            o_PREADY <= 'b0;
            o_PRDATA <= 'b0;
            o_PSLVERR <= 'b0;
        end
    end
endmodule
