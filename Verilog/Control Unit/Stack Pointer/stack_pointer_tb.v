`timescale 1ns/1ns
`include "Control Unit/Stack Pointer/stack_pointer.v"

module stack_pointer_tb;
    reg push, pop, clk;
    wire [9:0] SP;
    wire stack_overflow;

    stack_pointer sp(push, pop, clk, SP, stack_overflow);

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("stack_pointer_tb.vcd");
        $dumpvars(0, stack_pointer_tb);

        push = 1; pop = 0;
        #15

        pop = 1; push = 0;
        #10

        push = 1; pop = 0;
        #25

        push = 0; pop = 1;
        #40

        $finish;
    end

endmodule