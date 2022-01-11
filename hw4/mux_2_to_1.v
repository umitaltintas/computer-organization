module mux_2_to_1(a , b , sel, out );

input a, b;
input sel;
output out;

wire or1, or2;
wire sel_not;

not(sel_not, sel);

and first(or1, b, sel);
and second(or2, a, sel_not);
or or_gate(out, or1, or2);

endmodule

module mux_2_to_1_32bit(a [31:0], b [31:0], sel, out [31:0]);

input [31:0] a, b;
input sel;
output [31:0] out;

wire [31:0] or1, or2;
wire sel_not;

not(sel_not, sel);

wire [31:0] sel32 = {32{sel}}; // extend bit
wire [31:0] sel_not32 = {32{sel_not}};

AND_n_bit first(or1[31:0], b[31:0], sel32 [31:0]);
AND_n_bit second(or2[31:0], a[31:0], sel_not32 [31:0]);
OR_n_bit or_gate(out[31:0], or1[31:0], or2[31:0]);

endmodule

module mux_2_to_1_3bit(a [3:0], b [3:0], sel, out [3:0]);

input [4:0] a, b;
input sel;
output [4:0] out;

wire [4:0] or1, or2;
wire sel_not;

not(sel_not, sel);

wire [4:0] sel32 = {5{sel}}; // extend bit
wire [4:0] sel_not32 = {5{sel_not}};

and first[3:0](or1[4:1], b[4:1], sel32[4:1]);
and(or1[0], b[0], sel32[0]);
and second[3:0](or2[4:1], a[4:1], sel_not32[4:1]);
and (or2[0], a[0], sel_not32[0]);
or or_gate[3:0](out[4:1], or1[4:1], or2[4:1]);
or(out[0], or1[0], or2[0]);

endmodule
