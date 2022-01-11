`define DELAY 20

module or_testbench();

reg [31:0] input1, input2;
wire [31:0] out;
wire caryout;

or_32 test_or(out,input1,input2);

initial begin
input1 = 32'd0;
input2 = 32'd1;
#`DELAY;
input1 = 32'd4;
input2 = 32'd1;
#`DELAY;
end

initial
begin
$monitor("time = %2d, input1 =%d, input2=%d out=%d " , $time, input1, input2, out);
end


endmodule