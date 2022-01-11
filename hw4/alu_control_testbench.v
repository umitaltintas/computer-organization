`define DELAY 20
module alu_ctr_testbench();

reg [2:0] o; // aluop
reg [2:0] f; // function field
wire [2:0] alu_ctr;

alu_control test(alu_ctr, f, o);
// ins	aluop2	aluop1	aluop0	f2	f1	f0	c2	c1	c0	
// rType	0	0	0	0	0	0	0	0	0	AND
// rType	0	0	0	0	0	1	0	0	1	ADD
// rType	0	0	0	0	1	0	0	1	0	SUB
// rType	0	0	0	0	1	1	0	1	1	XOR
// rType	0	0	0	1	0	0	1	0	0	NOR
// rType	0	0	0	1	0	1	1	0	1	OR
// add	0	0	1	x	x	x	0	0	1	ADD
// and	0	1	0	x	x	x	0	0	0	AND
// or	0	1	1	x	x	x	1	0	1	OR
// nor	1	0	0	x	x	x	1	0	0	NOR
// sub	1	0	1	x	x	x	0	1	0	SUB
// slt	1	1	0	x	x	x	1	1	0	SLT
initial begin
//rType and test
f = 3'b000; // 
o = 3'b000;
#`DELAY;
// rtype add test
f = 3'b001; // 
o = 3'b000;
#`DELAY;
// rtype sub test
f = 3'b010; // 
o = 3'b000;
#`DELAY;
// rtype xor test
f = 3'b011; // 
o = 3'b000;
#`DELAY;
// rtype nor test
f = 3'b100; // 
o = 3'b000;
#`DELAY;
// rtype or test
f = 3'b101; //
o = 3'b000;
#`DELAY;
// f type add test
f = 3'b000; //
o= 3'b001;
#`DELAY;
// f type and test
f = 3'b000; //
o = 3'b010;
#`DELAY;
// f type or test
f = 3'b000; //
o = 3'b011;
#`DELAY;
// f type nor test
f = 3'b000; //
o = 3'b100;
#`DELAY;
// f type sub test
f = 3'b000; //
o = 3'b101;
#`DELAY;
// f type slt test
f = 3'b000; //
o = 3'b110;
#`DELAY;
end

initial
begin
$monitor("time = %d, o=%3b, f=%3b, out=%3b,", $time, o, f, alu_ctr);
end

endmodule
