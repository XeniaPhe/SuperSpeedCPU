`include "../Half Subtractor/half_subtractor.v"

module full_subtractor(
    input i0, i1, bin,
    output d, bout);

    wire d1, b1, b2;
    half_subtractor hs0(i0, i1, d1, b1);
    half_subtractor hs1(d1, bin, d, b2);

    or o(bout, b1, b2);

endmodule