`include "bit_set.sv"

module bit_set_tb;
	parameter M=8;
	//input
	logic [M-1:0] i_argA;
	logic [M-1:0] i_argB;
	//output
	logic [M-1:0] o_y;
	logic ERROR;
	
	bit_set uut (.i_argA(i_argA), .i_argB(i_argB), .o_y(o_y), .ERROR(ERROR));
		initial begin
		$dumpfile("bit_set.vcd");
		$dumpvars(0, bit_set_tb);
		// i_argB < 0
			i_argA = 7;
			i_argB = -2;
			#10;
		// i_argB = 0
			i_argA = 7;
			i_argB = 0;
			#10;
		// i_argB > 0
			i_argA = 7;
			i_argB = 11;
			#10;
			
		end
		
endmodule