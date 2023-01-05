`include "Adder/Half Adder/half_adder.v"

module ten_bit_incrementer(
    input [9:0] a,
    output [9:0] s,
    output o);

    wire [9:0] c;

    half_adder ha0(1'b1, a[0], s[0], c[0]);

    genvar i;

    generate
        for(i = 1; i < 10; i = i + 1) begin
            half_adder hai(c[i - 1], a[i], s[i], c[i]);
        end
    endgenerate

    assign o = c[9];

endmodule