`include "Adder/20 Bit Adder/twenty_bit_adder.v"
`include "Subtractor/20 Bit Subtractor/twenty_bit_subtractor.v"
`include "Bitwise And/twenty_bit_bitwise_and.v"
`include "Bitwise Or/twenty_bit_bitwise_or.v"
`include "Equality Comparator/equality_comparator.v"

module ALU(
    input [19:0] i0, i1,
    input [2:0] op_select,
    input be_select,
    output [19:0] s,
    output cout, e);

    equality_comparator comp(i0, i1, be_select, e);

    wire is_arithmetic = op_select[2] ~| op_select[1];
    wire adder_cout = 0;
    wire subtractor_bout = 0;

    case (op_select)
        3'b000 : begin twenty_bit_adder add(i0, i1, s, adder_cout); end
        3'b001 : begin twenty_bit_subtractor subtract(i0, i1, s, subtractor_bout); end
        3'b010 : begin twenty_bit_bitwise_and bwand(i0, i1, s); end
        3'b011 : begin twenty_bit_bitwise_or bwor(i0, i1, s); end
        3'b100 : begin twenty_bit_bitwise_xor bwxor(i0, i1, s); end
    endcase

    assign cout = ( op_select[0] == 1'b1 ? subtractor_bout : adder_cout ) & is_arithmetic;

endmodule