
module Zero(Zero_out, R2);

parameter	word_size = 32;		// the default size 

input		[31:0]	R2;
output		Zero_out;
wire or_out;

or OR1(or_out, R2[31],R2[30],R2[29],R2[28],R2[27],R2[26],R2[25],R2[24],R2[23],R2[22],R2[21],R2[20],R2[19],R2[18],R2[17],R2[16],R2[15],R2[14],R2[13],R2[12],R2[11],R2[10],R2[9],R2[8],R2[7],R2[6],R2[5],R2[4],R2[3],R2[2],R2[1],R2[0]);
not NOT1(Zero_out, or_out);
endmodule
