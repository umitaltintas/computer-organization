
module NOT_n_bit(NOT_out, R2);

parameter	word_size = 32;		// the default size of this n bit adder

input		[31:0]	R2;
output	[31:0]	NOT_out;

not NOT1[31:0]	(NOT_out, R2);

endmodule
