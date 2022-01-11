module alu_control(alu_ctr, f, op);
input[2:0] op; // aluop
input [2:0] f; // function field
output [2:0] alu_ctr;

wire f_not[2:0];
not not1(f_not[0], f[0]);
not not2(f_not[1], f[1]);
not not3(f_not[2], f[2]);

wire op_not[2:0];
not not4(op_not[0], op[0]);
not not5(op_not[1], op[1]);
not not6(op_not[2], op[2]);


wire and1, and2, and3, and4, and5 ,and6,and7,and8,and9, or1, or2;




//alu_ctr[2] =	op_not[1] op_not[0] f[2] + op[1] op[0] + op[2] op_not[0]

and and_1(and1,op_not[1], op_not[0], f[2]);
and and_2(and2, op[1], op[0]);
and and_3(and3, op[2], op_not[0]);
or or_1(alu_ctr[2],and1,and2,and3);





//alu_ctr[1]= op_not[2] op_not[1] op_not[0] f[1] + op[2] op[0] + op[2] op[1]

and and_4(and4, op_not[2], op_not[1], op_not[0], f[1]);
and and_5(and5, op[2], op[0]);
and and_6(and6, op[2], op[1]);
or or_2(alu_ctr[1], and4, and5, and6);


//alu_ctr[0]= op_not[2] op_not[1] f[0] + op_not[2] op[0]

and and_7(and7, op_not[2], op_not[1], f[0]);
and and_8(and8, op_not[2], op[0]);
or or_3(alu_ctr[0], and7, and8);

endmodule
