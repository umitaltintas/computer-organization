
module SUB_n_bit(c_out, SUB_out, R2, R3);

parameter	word_size = 32;		// the default size of this n bit subtractor

input		[31:0]	R2, R3;

output	[31:0]	SUB_out;
output							c_out;

wire		[31:0]	c_inner, not_R3;

NOT_n_bit	#(word_size) NOTN (not_R3, R3);

// the 2's complement of R3 is added to R2 
// the carry-in is hardwired to 1 in order to add 1 to not_R3, the 1's complement of R3 
// the c_out of the ith 1-bit full adder is the c_in of the (i+1)th full adder
ADD_n_bit 	#(word_size) ADDER	(c_out, SUB_out, R2, not_R3, 1'b1);

endmodule

