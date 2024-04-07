module bit_shift #(parameter M=8)( i_argA, i_argB, o_y, ERROR);

	//input
	input logic [M-1:0] i_argA; //M-bitowe wejscie A
	input logic [M-1:0] i_argB; //M-bitowe wejscie B
	//output
	output logic [M-1:0] o_y; //wyjscie
	output logic ERROR; //blad
	
	always@(*) begin
		ERROR = 0; //'zerowanie' bledu na starcie
		if(i_argB < 'b0)
		begin
			ERROR = 1; //pojawienie sie bledu
			o_y = 0; //wyjscie wynosi 0
		end
		else 
		begin
			ERROR = 0; //blad sie 'zeruje'
			o_y = i_argA <<< i_argB; //left shifting
		end
	end

endmodule