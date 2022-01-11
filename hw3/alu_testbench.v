`define DELAY 20
module alu_testbench();

reg [31:0] a, b;
reg [2:0] opt;
wire [31:0] out;

alu alu_test(a [31:0],b [31:0],opt,out[31:0]);

initial begin
// add test
a = 32'd2;
b = 32'd6;
opt = 3'b000;

#`DELAY;
// sub test
a = 32'd15;
b = 32'd3;
opt = 3'b010;

#`DELAY;
// and test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
opt = 3'b110;


#`DELAY;
// or test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
opt = 3'b111;


#`DELAY;
// xor test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
opt = 3'b001;


#`DELAY;
// mult test
a = 32'd5;
b = 32'd8;
opt = 3'b011;
#`DELAY;


#`DELAY;
// slt test
a = 32'd5;
b = 32'd8;
opt = 3'b100;
#`DELAY;



#`DELAY;
// nor test
a = 32'd5;
b = 32'd8;
opt = 3'b101;
#`DELAY;

end
initial
begin
$monitor("time = %d, a =%32b, b=%32b, sel=%3b, out=%32b", $time, a, b, opt, out);
end


endmodule