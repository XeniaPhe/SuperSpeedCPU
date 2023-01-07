`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"
`include "Control Unit/Next State/next_state.v"

module state_manager(
    input alu, ld, st, push, pop, jump, be, clk,
    output s2, s1, s0);

    wire s2_n, s1_n, s0_n;

    rising_edge_triggered_d_flipflop s2f(s2_n, 1'b1, clk, s2);
    rising_edge_triggered_d_flipflop s1f(s1_n, 1'b1, clk, s1);
    rising_edge_triggered_d_flipflop s0f(s0_n, 1'b1, clk, s0);

    next_state nextstate(alu, ld, st, push, pop, jump, be, s2, s1, s0, s2_n, s1_n, s0_n);
endmodule