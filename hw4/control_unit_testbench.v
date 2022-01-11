`define DELAY 20
module control_unit_testbench();

reg [3:0] op;
wire regDst, aluSrc, memToReg,regWrite,memRead,memWrite,branch,branchN;
wire [2:0] aluop;

control_unit test (regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, branchN,aluop,op);


initial begin
op = 4'b0000;
#`DELAY;
op = 4'b0001;
#`DELAY;
op = 4'b0010;
#`DELAY;
op = 4'b0011;
#`DELAY;
op = 4'b0100;
#`DELAY;
op = 4'b0101;
#`DELAY;
op = 4'b0110;
#`DELAY;
op = 4'b0111;
#`DELAY;
op = 4'b1000;
#`DELAY;
op = 4'b1001;
end
 
 
initial
begin
$monitor("time=%2d, op=%4b, regdst=%1b, alusrc=%1b, memtoreg=%1b, regwrite=%1b, memread=%1b, memwrite=%1b, branch=%1b, branchn=%1b, aluop=%3b",
													$time,op,regDst,aluSrc, memToReg,regWrite,memRead,memWrite,branch,branchN,aluop);
end
 


endmodule
