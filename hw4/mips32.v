module mips32(clock);
wire [15:0] instruction;



input clock;

// control unit outputs
wire regDst, aluSrc, memToReg, regWrite, regWrite2, memRead, memWrite, branch, branchNotE;
wire [2:0] aluop;

// alu outputs
wire alu_zero_out, alu_zero_out_not;
wire [31:0] alu_result;
wire [2:0] alu_control_out;

// mux outputs
wire [4:0] mux_rt_rs_out;
wire [31:0]  mux_lui_out, mux_branch_out, mux_aluSrc_out, adder_branch_out, mux_j_out, mux_jr_out;

// register
wire[31:0] read_data_1, read_data_2;
wire [31:0] memToRegOut;


// data memory
wire[31:0] memory_read_data_out;

wire [31:0] new_out, pc_plus_1, sign_extend_out;
wire or_j_out, and_branch_out, and_branchNot_out;

wire jr;

wire [31:0] pc_reg_out;


reg reset;

//program counter register
register_32 pc_reg(mux_branch_out, reset, pc_reg_out, clock);



//program counter adder
wire [31:0] constant1 = 32'd1;
wire co;
ADD_n_bit adder_pc_plus_1(co,pc_plus_1,  pc_reg_out, constant1,1'b0);



instruction_memory instruction_memory1(instruction, pc_reg_out[11:0]); // 12 bit address is enough to represent 16KB instruction memory

//control unit
control_unit control_unit1(regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, branchNotE, aluop, instruction[15:12]); // opcode


// mux in front of write register
mux_2_to_1_3bit mux_rt_rs(instruction[8:6],instruction[5:3], regDst, mux_rt_rs_out);					  


//register block    
mips_registers register_block(read_data_1, read_data_2, memToRegOut, instruction[11:9], instruction[8:6], mux_rt_rs_out, regWrite, clock );


sign_extend_6_32 sign_extend(instruction[5:0], sign_extend_out); // immediate


ADD_n_bit adder_branch(.ADD_out(adder_branch_out), .R2(sign_extend_out), .R3(pc_plus_1));

mux_2_to_1_32bit mux_aluSrc(read_data_2, sign_extend_out, aluSrc, mux_aluSrc_out);

alu_control alu_control_1(alu_control_out, instruction[5:0], aluop);

ALU_3_bit_op alu(alu_zero_out,alu_result,read_data_1, mux_aluSrc_out, alu_control_out);

and isBranchZero(and_branch_out, branch, alu_zero_out);
not negateZero(alu_zero_out_not, alu_zero_out);
and isBranchNotZero(and_branchNot_out, branchNotE, alu_zero_out_not);
wire orBranch_out;
or orBranch(orBranch_out, and_branchNot_out, and_branch_out);


mux_2_to_1_32bit mux_branch(pc_plus_1, adder_branch_out, orBranch_out, mux_branch_out);

mips_data_memory data_mem(memory_read_data_out, alu_result[15:0], read_data_2, memWrite, memRead, clock); // 16 bit address is enough to represent 256KB data memory

mux_2_to_1_32bit mux_memToReg(alu_result, memory_read_data_out, memToReg, memToRegOut);


endmodule
