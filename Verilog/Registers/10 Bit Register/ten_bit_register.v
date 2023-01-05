`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"

module ten_bit_register(
    input [9:0] d,
    input clk, w, reset,
    output [9:0] q);

    genvar i;

    generate
        for(i = 0; i < 10; i = i + 1) begin
            rising_edge_triggered_d_flipflop flipflopi(d[i], w, clk, reset, q[i]);
        end
    endgenerate
endmodule