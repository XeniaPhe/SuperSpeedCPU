`include "Adder/20 Bit Adder/twenty_bit_adder.v"
`include "Subtractor/20 Bit Subtractor/twenty_bit_subtractor.v"
`include "Bitwise And/twenty_bit_bitwise_and.v"
`include "Bitwise Or/twenty_bit_bitwise_or.v"
`include "Equality Comparator/equality_comparator.v"

module ALU(
    input [19:0] i0, i1,
    input [2:0] op_select,
    input be_select,
    output reg [19:0] s,
    output cout, e);

    equality_comparator comp(i0, i1, be_select, e);
    
    wire [19:0] _add, _subt, _and, _or, _xor;
    wire adder_cout, subtractor_bout, _cout, is_arithmetic;

    twenty_bit_adder adder(i0, i1, _add, adder_cout);
    twenty_bit_subtractor subtractor(i0, i1, _subt, subtractor_bout);
    twenty_bit_bitwise_and bwand(i0, i1, _and);
    twenty_bit_bitwise_or bwor(i0, i1, _or);
    twenty_bit_bitwise_xor bwxor(i0, i1, _xor);

    nor n(is_arithmetic, op_select[2], op_select[1]);
    assign _cout = op_select[0] ? subtractor_bout : adder_cout;
    and a(cout, _cout, is_arithmetic);

    always @(*) begin
        case (op_select)
            3'b000  : s <= _add; 
            3'b001  : s <= _subt;
            3'b010  : s <= _and;
            3'b011  : s <= _or;
            3'b100  : s <= _xor;
            default : s <= 20'd0;
        endcase
    end
endmodule