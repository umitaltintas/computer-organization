
module ADD_n_bit(c_out, ADD_out, R2, R3, c_in);

parameter	word_size = 32;		// the default size of this n bit adder

input		[31:0]	R2, R3;
input								c_in;

output	[31:0]	ADD_out;
output							c_out;

wire		[31:0]	c_inner;

// the c_out of the ith 1-bit full aderr is the c_in of the (i+1)th full adder 
ADD_1_bit 	ADDER[31:0]	({c_out, c_inner[31:1]}, ADD_out, R2, R3, {c_inner[31:1], c_in});

endmodule
