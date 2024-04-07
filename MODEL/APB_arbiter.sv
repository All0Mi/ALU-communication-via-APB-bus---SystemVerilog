module arbiter#(
    parameter SEL_WIDTH = 3,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    // Slave 1
    input logic s_ready_1,
    input logic [DATA_WIDTH-1:0] s_data_1,
    input logic s_error_1,
    // Slave 2
    input logic s_ready_2,
    input logic [DATA_WIDTH-1:0] s_data_2,
    input logic s_error_2,
    // Slave 3
    input logic s_ready_3,
    input logic [DATA_WIDTH-1:0] s_data_3,
    input logic s_error_3,

    // Magistrala
    input [SEL_WIDTH-1:0] sel, // to select
    output logic [DATA_WIDTH-1:0] o_arbiter_DATA,
    output logic o_arbiter_READY,
    output logic o_arbiter_ERROR,
    output logic [SEL_WIDTH-1:0] o_arbiter_SEL
);

always_comb begin
    case(sel)
        3'b001: begin
            o_arbiter_DATA = s_data_1;
            o_arbiter_ERROR = s_error_1;
            o_arbiter_READY = s_ready_1;
            o_arbiter_SEL = 2'b00;
        end
        3'b010: begin
            o_arbiter_DATA = s_data_2;
            o_arbiter_ERROR = s_error_2;
            o_arbiter_READY = s_ready_2;
            o_arbiter_SEL = 2'b01;
        end
        3'b100: begin
            o_arbiter_DATA = s_data_3;
            o_arbiter_ERROR = s_error_3;
            o_arbiter_READY = s_ready_3;
            o_arbiter_SEL = 2'b10;
        end
        default: begin
            o_arbiter_DATA = '0;
            o_arbiter_ERROR = 1'b0;
            o_arbiter_READY = 1'b0;
            o_arbiter_SEL = 2'b00;
        end
    endcase
end

endmodule
