
module mult_32 (clk,reset,start,multiplier_input,multiplicand_input,product_out);

parameter N=32;

//Input Port
input clk;
input reset;
input start;
input [N-1:0] multiplier_input;
input [N-1:0] multiplicand_input;

//Output Port
output reg[2*N-1:0] product_out;
reg[N-1:0] count;

//
// reg [N-1:0] Multiplier;
reg [N-1:0] multiplicant_state;
wire [2*N-1:0] product_wire;
wire shift_l,shift_r,load,write,increment;

//Register for Multiplier
always@(posedge clk)
begin
	if(reset)
	begin
		multiplicant_state <= 'b0;
       product_out <= 'b0;
		 end
	else if(load)
	begin
		multiplicant_state <= multiplicand_input;	// load with the input value of multiplier_input
      product_out <= {{N{1'b0}},multiplier_input};
		end
	else if(shift)
	begin
		product_out <= {1'b0,product_out[N-1:1]};	// shift right operation
		end
    else if(write)
	 begin
        product_out <= {add_result[N-1:0],product_out[N-1:0]};
		  end

end

//A counter to calcuate the repetitions
always@(posedge clk or posedge reset)
begin
	if(reset)
		count <= 32'b0;
	else if(increment)
		count <= count_wire;
end
		

// calculate count;
wire[N-1:0] count_wire;
add_32 add_count(count_wire,count,32'b1);




	
//Instantiating the control unit
control_unit CU 
(
	.clk(clk),
	.reset(reset),
	.start(start),
	.lsb(product_out[0]),
	.load(load),
	.shift(shift),
	.write(write),
   .counter32(count[5]),
	.increment(increment)
);

wire [N-1:0] add_result ;
adder_32  adder_multiplier (add_result,multiplicant_state,product_wire[2*N-1:N]);	





endmodule 

