`define DELAY 20
module alu_testbench();

reg [31:0] a, b;
reg [2:0] sel;
wire [31:0] out;
wire zero;

ALU_3_bit_op alu_test( zero,out[31:0],a [31:0],b [31:0],sel);

initial begin
// add test
a = 32'd2;
b = 32'd6;
sel = 3'b001;
#`DELAY;
// add w/overflow test
a = 32'd2147483647;
b = 32'd2147483647;
sel = 3'b001;
#`DELAY;
// sub test
a = 32'd15;
b = 32'd3;
sel = 3'b010;
#`DELAY;
// sub test
a = 32'd0;
b = 32'd2147483647;
sel = 3'b010;
#`DELAY;
// and test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b000;
#`DELAY;
// or test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b101;
#`DELAY;
// xor test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b011;
#`DELAY;
// sub test w/zero out
a = 32'd2;
b = 32'd2;
sel = 3'b010;
#`DELAY;
// nor test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b100;
//slt test
#`DELAY;
a = 32'd9;
b = 32'd8;
sel = 3'b110;
#`DELAY;
end

initial
begin
$monitor("time = %d, a =%32b, b=%32b, sel=%3b, out=%32b, zero=%1b", $time, a, b, sel, out, zero);
end


endmodule
