
module NOR_n_bit(NOR_out, R2, R3);

parameter	word_size = 32;		// the default size 

input		[31:0]	R2, R3;
output	[31:0]	NOR_out;

nor NOR1[31:0]	(NOR_out, R2, R3);

endmodule
