module regg #(parameter M=8)
(input logic i_clk,
 input logic i_reset,
 input logic [M-1:0] i_in,
 output logic [M-1:0] o_out);

always_ff @(posedge i_clk)
begin
    if(i_reset == 1'b1)
    o_out <= i_in;
    else 
    o_out <= '0;
    
end
endmodule