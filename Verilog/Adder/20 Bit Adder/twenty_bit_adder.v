`include "Adder/Full Adder/full_adder.v"

module twenty_bit_adder(
    input [19:0] i0, i1, 
    output [19:0] s, 
    output cout);
    
    wire [19:0] c;

    half_adder ha(i0[0], i1[0], s[0], c[0]);

    genvar i;

    generate
        for(i = 1; i < 20; i = i + 1) begin
            full_adder fai(i0[i], i1[i], c[i -1], s[i], c[i]);
        end
    endgenerate

    assign cout = c[19];
endmodule