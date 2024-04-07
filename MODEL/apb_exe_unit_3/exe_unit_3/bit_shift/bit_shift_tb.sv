`include "bit_shift.sv"

module bit_shift_tb;
	parameter M=8;
	//input
	logic [M-1:0] i_argA;
	logic [M-1:0] i_argB;
	//output
	logic [M-1:0] o_y;
	logic ERROR;
	
	bit_shift uut (.i_argA(i_argA), .i_argB(i_argB), .o_y(o_y), .ERROR(ERROR));
		initial begin
		$dumpfile("bit_shift.vcd");
		$dumpvars(0, bit_shift_tb);
		// i_argB < 0
			i_argA = 8;
			i_argB = -5; //BLAD
			#10;
		// i_argA < 0 
			i_argA = -8; //A ujemne
			i_argB = 5;
			#10;
		// i_argA > 0
			i_argA = 8; //A dodatnie
			i_argB = 5; 
			#10;
			
		end
		
endmodule