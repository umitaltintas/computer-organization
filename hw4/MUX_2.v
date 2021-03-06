module MUX_2(out, a, b, sel);

input a, b, sel;
output out;
wire not_sel, sel_and_a, not_sel_and_b;

not 	not1(not_sel, sel);
and	and1(sel_and_b, sel, b);
and	and2(not_sel_and_a, not_sel, a);
or		or1(out, sel_and_b, not_sel_and_a);

endmodule
