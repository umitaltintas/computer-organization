
module AND_n_bit(AND_out, R2, R3);

parameter	word_size = 32;		// the default size 

input		[31:0]	R2, R3;
output	[31:0]	AND_out;

and AND1[31:0]	(AND_out, R2, R3);

endmodule
