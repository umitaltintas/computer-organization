
module OR_n_bit(OR_out, R2, R3);

parameter	word_size = 32;		// the default size 

input		[31:0]	R2, R3;
output	[31:0]	OR_out;

or OR1[31:0]	(OR_out, R2, R3);

endmodule

