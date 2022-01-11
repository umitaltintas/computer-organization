module not_2(out, a);
input [1:0] a;
output [1:0] out;

not f(out[0], a[0]),

    s(out[1], a[1]);
endmodule

module not_4(out, a);
input [3:0] a;
output [3:0] out;

not_2 f(out[1:0], a[1:0]),
          s(out[3:2], a[3:2]);
endmodule

module not_8(out, a);
input [7:0] a;
output [7:0] out;

not_4 f(out[3:0], a[3:0]),
          s(out[7:4], a[7:4]);
endmodule

module not_16(out, a);
input [15:0] a;
output [15:0] out;

not_8 f(out[7:0], a[7:0]),
          s(out[15:8], a[15:8]);
endmodule
module not_32(out,
                  a,
                 );
    input [31:0] a;
    output [31:0] out;
    
    not_16 f(out[15:0], a[15:0]),
    s(out[31:16], a[31:16]);
endmodule
