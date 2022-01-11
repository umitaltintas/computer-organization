module control_unit(regDst, aluSrc, memToReg, regWrite, memRead, 
                    memWrite, branch, branchNotE,  aluop, opcode);	  
input [3:0] opcode;
output [2:0] aluop;
output regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, branchNotE;

wire rType, lw, sw, beq, bne, or_i, nor_i, add_i,and_i,slt_i;
wire [3:0] opcode_not;

not not4[3:0] (opcode_not, opcode);

//rType
and a0(rType, opcode_not[3], opcode_not[2], opcode_not[1], opcode_not[0]);         
//add_i                    
and a1(add_i, opcode_not[3], opcode_not[2], opcode_not[1],opcode[0]);
//and_i
and a2(and_i, opcode_not[3], opcode_not[2], opcode[1],opcode_not[0]);
//or_i
and a3(or_i, opcode_not[3], opcode_not[2], opcode[1],opcode[0]);
//slt_i
and a4(nor_i, opcode_not[3],opcode[2], opcode_not[1],opcode_not[0]);
//beq
and a5(beq, opcode_not[3],opcode[2], opcode_not[1],opcode[0]);
//bne
and a6(bne, opcode_not[3],opcode[2], opcode[1],opcode_not[0]);
//slt_i
and a7(slt_i, opcode_not[3],opcode[2], opcode[1],opcode[0]);
//lw
and a8(lw, opcode[3],opcode_not[2], opcode_not[1],opcode_not[0]);
//sw
and a9(sw, opcode[3],opcode_not[2], opcode_not[1],opcode[0]);

buf b1(regDst, rType);
or o2(regWrite, rType, add_i, and_i, or_i, nor_i, slt_i, lw);
or o1(aluSrc, sw, add_i, and_i, or_i, nor_i, slt_i, lw);
buf b5(memWrite, sw);
buf b4(memRead, lw);
buf b2(memToReg, lw);
buf b7(branchNotE, bne);
buf b6(branch, beq);
or o3(aluop[2], nor_i, beq,bne,slt_i);
or o4(aluop[1],and_i,or_i,slt_i);
or o5(aluop[0],add_i,or_i,beq,bne,lw,sw);

endmodule