`include "Bitwise Xor/twenty_bit_bitwise_xor.v"

module equality_comparator(
    input [19:0] i0, i1,
    input be_select,
    output s);

    wire select_not, not_eq;
    wire [19:0] b_xor;

    not n(select_not, be_select);
    twenty_bit_bitwise_xor bwxor(i0, i1, b_xor);
    assign not_eq = b_xor != 20'd0;
    xnor xn(s, not_eq, select_not);
endmodule