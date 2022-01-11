module xor_2(out, a, b);
input [1:0] a, b;
output [1:0] out;

xor f(out[0], a[0], b[0]),
    s(out[1], a[1], b[1]);
endmodule

module xor_4(out, a, b);
input [3:0] a, b;
output [3:0] out;

xor_2_bit f(out[1:0], a[1:0], b[1:0]),
          s(out[3:2], a[3:2], b[3:2]);
endmodule

module xor_8(out, a, b);
input [7:0] a, b;
output [7:0] out;

xor_4_bit f(out[3:0], a[3:0], b[3:0]),
          s(out[7:4], a[7:4], b[7:4]);
endmodule

module xor_16(out, a, b);
input [15:0] a, b;
output [15:0] out;

xor_8_bit f(out[7:0], a[7:0], b[7:0]),
          s(out[15:8], a[15:8], b[15:8]);
endmodule
module xor_32(out,
                  a,
                  b);
    input [31:0] a, b;
    output [31:0] out;
    
    xor_16_bit f(out[15:0], a[15:0], b[15:0]),
    s(out[31:16], a[31:16], b[31:16]);
endmodule
