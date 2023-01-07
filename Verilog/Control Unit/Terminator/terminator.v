`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"
`include "Latches/Falling Edge Triggered D Flip-Flop/falling_edge_triggered_d_flipflop.v"

module terminator(
    input decode, halt_instruction, stack_overflow, instruction_end, pc_overflow, clk,
    output halted);

    wire cpu_started, pc_overflowed, pc_overflowed1, pc_overflowed2, halt_instruction1, halt, _halted;

    rising_edge_triggered_d_flipflop start_tracker(decode, decode, clk, cpu_started);

    rising_edge_triggered_d_flipflop pc_overflow_tracker(pc_overflow, pc_overflow, clk, pc_overflowed);

    and(halt_instruction1, cpu_started, halt_instruction);
    and(pc_overflowed1, instruction_end, pc_overflowed);

    falling_edge_triggered_d_flipflop delay(1'b1, 1'b1, pc_overflowed1, pc_overflowed2);

    or(halt, halt_instruction1, pc_overflowed2, stack_overflow);

    rising_edge_triggered_d_flipflop remember_halt(halt, halt, clk, _halted);

    or(halted, halt, _halted);
endmodule