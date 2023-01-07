`include "Adder/Incrementer/ten_bit_incrementer.v"
`include "Subtractor/Decrementer/ten_bit_decrementer.v"
`include "Registers/10 Bit Register/ten_bit_register.v"

module stack_pointer(
    input push, pop, clk,
    output [9:0] SP,
    output stack_overflow);

    wire w_enabled, incr_overflow, decr_overflow, push_overflow, pop_overflow;
    wire [9:0] incr_q, decr_q;

    or(w_enabled, push, pop);

    ten_bit_register #(.INIT(10'd1023)) sp(.d(push ? decr_q : incr_q), .clk(clk), .w(w_enabled), .q(SP));

    ten_bit_incrementer incr(SP, incr_q, incr_overflow);
    ten_bit_decrementer decr(SP, decr_q, decr_overflow);

    and(push_overflow, decr_overflow, push);
    and(pop_overflow, incr_overflow, pop);
    or(stack_overflow, push_overflow, pop_overflow);
endmodule