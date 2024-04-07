`include "comparator_synth.sv"

module comparator_tb_synth;
	parameter M=8;
	//input
	logic [M-1:0] i_argA;
	logic [M-1:0] i_argB;
	//output
	logic o_y;
	
	//test UUT
	comparator_synth uut( .i_argA(i_argA), .i_argB(i_argB), .o_y(o_y));
		initial begin
			$dumpfile("comparator.vcd");
			$dumpvars(0, comparator_tb_synth);
			i_argA = 11;
			i_argB = 14;
			#100;
			i_argA = 11;
			i_argB = 9;
			#100;
			i_argA = 10;
			i_argB = 10;
			#100;
		end
		
endmodule
