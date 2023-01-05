module twenty_bit_bitwise_xor(
    input [19:0] i0, i1,
    output [19:0] s);

    genvar i;

    generate
        for(i = 0; i < 20; i = i + 1) begin
            xor xi(s[i], i0[i], i1[i]);
        end
    endgenerate
endmodule