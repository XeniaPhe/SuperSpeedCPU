`include "../Half Subtractor/half_subtractor.v"

module ten_bit_decrementer(
    input [9:0] a,
    output [9:0] s,
    output o);

    wire [9:0] b;

    half_subtractor hs0(a[0], 1'b1, s[0],b[0]);

    genvar i;

    generate
        for(i = 1; i < 10; i = i + 1) begin
            half_subtractor hsi(a[i], b[i - 1], s[i], b[i]);
        end
    endgenerate

    assign o = b[9];
endmodule