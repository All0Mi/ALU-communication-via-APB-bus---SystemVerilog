module comparator #(parameter M=8)(i_argA, i_argB, o_y);

input logic [M-1:0] i_argA; //M-bitowe wejscie A
input logic [M-1:0] i_argB; //M-bitowe wejscie B
output logic [M-1:0] o_y; //wyjscie

always @(i_argA or i_argB)
	begin
		if(i_argA > i_argB)	
			begin
				o_y = 0;
			end
		else
			begin
				o_y = 1;
			end
			
	end

endmodule
