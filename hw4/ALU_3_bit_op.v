
module ALU_3_bit_op(zero,alu_out, R2, R3, alu_ctr);

parameter	word_size = 32;	//the real size of this module

input		[word_size-1:0] R2, R3;
input 	[2:0]	alu_ctr;
output	[word_size-1:0] alu_out;
output zero;
wire		[word_size-1:0] XOR_out, NOT_out, ADD_out, SUB_out, OR_out, AND_out,NOR_out, out1, out2, out3, out4, out5, out6;
wire		c_out_add, c_out_sub, SLT_out;

XOR_n_bit	#(word_size) XOR1 (XOR_out,R3, R2);
NOT_n_bit	#(word_size) NOT1 (NOT_out, R2);
ADD_n_bit	#(word_size) ADD1 (c_out_add, ADD_out, R2, R3, 1'b0);
SUB_n_bit	#(word_size) SUB1 (c_out_sub, SUB_out, R2, R3);
OR_n_bit	#(word_size) OR1  (OR_out, R2, R3);
AND_n_bit	#(word_size) AND1 (AND_out, R2, R3);
SLT_n_bit	#(word_size) SLT1 (SLT_out, R2, R3);
NOR_n_bit	#(word_size) NOR1 (NOR_out, R2, R3);

MUX_2 MUX1[word_size-1:0]	(out1, AND_out, ADD_out, alu_ctr[0]);
MUX_2 MUX2[word_size-1:0]	(out2, SUB_out, XOR_out, alu_ctr[0]);
MUX_2 MUX3[word_size-1:0]	(out3, NOR_out, OR_out, alu_ctr[0]);
MUX_2 MUX4[word_size-1:0]	(out4, {31'b0,SLT_out}, 32'b0, alu_ctr[0]); 
MUX_2 MUX5[word_size-1:0]	(out5, out1, out2, alu_ctr[1]);
MUX_2 MUX6[word_size-1:0]	(out6, out3, out4, alu_ctr[1]);
MUX_2 MUX7[word_size-1:0]	(alu_out, out5, out6, alu_ctr[2]);

Zero Zero1(zero, alu_out);

endmodule
