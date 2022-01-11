module mips32_testbench ();

reg clock;
mips32 m(clock);
reg [7:0] line;

initial begin
	line = 0;
	clock = 0;
	m.pc_reg.out = 32'b0;
	$readmemb("registers.mem", m.register_block.registers);
	$readmemb("instructions.txt", m.instruction_memory1.instructions);
	$readmemb("data.txt", m.data_mem.data);	
end

always begin 
	#100 clock=~clock; 
end

always @(negedge clock) begin
if (line==3) begin // on the last line
	$writememb("registers.mem", m.register_block.registers);
	$writememb("data.txt", m.data_mem.data);
	$finish;
end

line <= line +1;
end

always @* begin
	$display("===========================");
	$display("time = %2d, clock=%1b", $time, clock);
	$display("instruction=%32b", m.instruction);
	$display("memToRegOut=%32b", m.memToRegOut);
	$display("pc=%32b", m.pc_reg_out);
	$display("pc_plus_1=%32b", m.pc_plus_1);
	$display("mux_branch_out=%32b", m.mux_branch_out);
	$display("alu_control_out=%32b", m.alu_control_out);
	$display("sign_extend_out=%32b", m.sign_extend_out);
	$display("alu_result=%32b", m.alu_result);
	$display("read_data_1=%32b", m.read_data_1);
	$display("read_data_2=%32b", m.read_data_2);

end

endmodule