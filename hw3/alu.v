module alu(a,
              b,
              opcode,
              alu_out,
);
    
    input wire[31:0] a, b;
    input [2:0] opcode;
    output [31:0] alu_out;
    
    wire[31:0] and_res, or_res, xor_res, add_res,nor_res;
	 wire[63:0] mult_res;
    wire [31:0] addder_first_input;
    wire [31:0] mux00out, mux01out,mux02out,mux10out,mux11out,mux20out;
    
    
    
    and_32 and_operation(and_res, a, b);
    or_32 or_operation(or_res, a, b); 
    xor_32 xor_opeartion(xor_res, a, b);
	 // multiplieri bitiremedim bu yuzden burasi calismayacak daha dogrusu burada bir clock source eklenmesi gerekiyor
	// mult_32 test_mult(clk,reset,start,multiplier_input,multiplicand_input,product_out);

    xor_32 _1s_complement(addder_first_input, b, opcode[1]);
    adder_32 adder(add_res, a, addder_first_inpu);

    slt_32 slt1 (a,b,slt_res);  
    nor_32 nor1(nor_res,a,b);
    
        
    
    
    
    //muxes for first decision
    mux_2_to_1_32bit mux00(add_res,xor_res,opcode[0],mux00out);
    mux_2_to_1_32bit mux01(add_res,mult_res[31:0],opcode[0],mux01out);
    mux_2_to_1_32bit mux02(slt_res,nor_res,opcode[0],mux02out);
    mux_2_to_1_32bit mux03(and_res,or_res,opcode[0],mux03out);
    
    //muxes for second decision
    mux_2_to_1_32bit mux10(mux00out,mux01out,opcode[1],mux10out);
    mux_2_to_1_32bit mux11(mux02out,mux03out,opcode[1],mux11out);
    
    //mux for third decision
    mux_2_to_1_32bit mux20(mux10out,mux11out,opcode[1],alu_out);
    
    
    
    
endmodule
    
