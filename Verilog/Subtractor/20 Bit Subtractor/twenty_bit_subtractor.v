`include "../Full Subtractor/full_subtractor.v"


module twenty_bit_subtractor(
    input [19:0] i0, i1,
    output [19:0] d,
    output bout);

    wire [19:0] b;

    half_subtractor hs(i0[0], i1[0], d[0], b[0]);

    genvar i;

    generate
        for(i = 1; i < 20; i = i + 1) begin
            full_subtractor fsi(i0[i], i1[i], b[i - 1], d[i], b[i]);
        end
    endgenerate

    assign bout = b[19];
endmodule