
module slt_32(input_first,
            input_second,
            result);
    
    input[31:0] input_first;
    input[31:0] input_second;
    output[31:0] result;
    
    wire second_not,  xor_res;
    wire [31:0] add_res;
    not_32 not1(second_not,input_second);
    
    adder_32 adder1(add_res, input_first,input_second);
	 
	 mux_2_to_1_32bit mux1(32'b1,32'b0,add_res[0],result);
    
endmodule
