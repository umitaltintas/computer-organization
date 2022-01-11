
module SLT_n_bit(SLT_out, R2, R3);

parameter	word_size = 32;

input		[31:0] R2, R3;
output	SLT_out;
wire		[31:0] SUB_out;
wire		c_out;

SUB_n_bit	#(word_size) S1 (c_out, {SLT_out, SUB_out[31:1]}, R2, R3);

endmodule
