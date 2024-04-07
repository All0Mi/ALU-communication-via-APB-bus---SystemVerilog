module register #(parameter N=8) (
  input logic clk,      
  input logic reset,    
  input logic [N-1:0] in, 
  output logic [N-1:0] out   
);

 always_ff @(posedge clk) begin // sync reset
    if (reset == 1'b0)
      out <= '0;
    else
      out <= in;
 end

endmodule
