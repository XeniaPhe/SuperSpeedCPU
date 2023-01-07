`ifndef RETDFF
`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"
`endif

module twenty_bit_register(
    input [19:0] d,
    input clk, w,
    output [19:0] q);

    genvar i;

    generate
        for(i = 0; i < 20; i = i + 1) begin
            rising_edge_triggered_d_flipflop flipflopi(d[i], w, clk, q[i]);
        end
    endgenerate
endmodule