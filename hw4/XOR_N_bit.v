
module XOR_n_bit(XOR_out, R2, R3);

parameter	word_size = 32;		// the default size 

input		[31:0]	R2, R3;
output	[31:0]	XOR_out;

xor XOR1[31:0]	(XOR_out, R2, R3);

endmodule
