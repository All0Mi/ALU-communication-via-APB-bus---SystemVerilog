`include "./MODEL/apb_exe_unit_2/exe_unit_2/Modules/negation.sv"
`include "./MODEL/apb_exe_unit_2/exe_unit_2/Modules/comparison.sv"
`include "./MODEL/apb_exe_unit_2/exe_unit_2/Modules/changebit.sv"
`include "./MODEL/apb_exe_unit_2/exe_unit_2/Modules/changecode.sv"

module exe_unit_w22 (i_argA, i_argB, i_oper, i_clk, i_rsn, o_result, o_status);
    parameter BITS = 4;
    parameter N = 2;

    input logic [BITS-1:0] i_argA;
    input logic [BITS-1:0] i_argB;
    input logic [N-1:0] i_oper;

    input logic i_clk;
    input logic i_rsn;

    output logic [BITS-1:0] o_result;
    output logic [3:0] o_status;

    logic error;
    logic overflow;

    logic [BITS-1:0] o_result_0;
    logic [BITS-1:0] o_result_1;
    logic [BITS-1:0] o_result_2;
    logic [BITS-1:0] o_result_3;
    logic error_0;
    logic error_2;
    logic error_3;

    integer i;
    integer x;

    negation #(BITS) negation (
        .i_argA(i_argA),
        .o_result(o_result_0),
        .error(error_0)
    );

    comparison #(BITS) comparison (
        .i_argA(i_argA),
        .i_argB(i_argB),
        .o_result(o_result_1)
    );

    changebit #(BITS) changebit (
        .i_argA(i_argA),
        .i_argB(i_argB),
        .o_result(o_result_2),
        .error(error_2)
    );

    changecode #(BITS) changecode (
        .i_argA(i_argA),
        .o_result(o_result_3),
        .error(error_3)
    );

    always_ff @(posedge i_clk, negedge i_rsn)
    begin
        if (i_rsn == 0)
        begin
            o_result = 0;
            o_status = 0;
        end
        else
        begin
        case (i_oper)
            0:
            begin
                error = error_0;
                overflow = error_0;
                o_result = o_result_0;
            end
            1:
            begin
                error = 0;
                overflow = 0;
                o_result = o_result_1;
            end
            2:
            begin
                error = error_2;
                overflow = 0;
                o_result = o_result_2;
            end
            3:
            begin
                error = error_3;
                overflow = error_3;
                o_result = o_result_3;
            end
            default:
            begin
                o_result = 0;
            end   
        endcase
//ERROR
        if (error == 1)
        begin
            o_status[3] = 1;
        end
        else
        begin
            o_status[3] = 0;
        end
//OVERFLOW
        if (overflow == 1)
        begin 
            o_status[2] = 1;
        end
        else
        begin
            o_status[2] = 0;
        end
//ODD
        x = 0;
        for (i=0; i<BITS; i++)
        begin
        if (o_result[i] == 1) 
            x=x+1;
        end
        if (x%2 != 0) 
        begin
            o_status[1] = 1;
        end
        else
        begin
            o_status[1] = 0;
        end
//ZERO
        if (o_result == '0)
        begin
            o_status[0] = 1;
        end
        else
        begin
            o_status[0] = 0;          
        end  
    end
    end
endmodule
