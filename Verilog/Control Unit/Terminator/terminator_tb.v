`timescale 1ns/1ns
`include "Control Unit/Terminator/terminator.v"

module terminator_tb;
    reg decode, halt_instruction, stack_overflow, instruction_end, pc_overflow, clk;
    wire halted_1, halted_2, halted_3, halted_4;

    terminator test_halt_instruction(decode, halt_instruction, 1'b0, 1'b0, 1'b0, clk, halted_1);
    terminator test_stack_overflow(1'b0, 1'b0, stack_overflow, 1'b0, 1'b0, clk, halted_2);
    terminator test_pc_overflow(1'b0, 1'b0, 1'b0, instruction_end, pc_overflow, clk, halted_3);
    terminator test_all(decode, halt_instruction, stack_overflow, instruction_end, pc_overflow, clk, halted_4);

    initial begin
        decode = 0;
        halt_instruction = 0;
        stack_overflow = 0;
        instruction_end = 0;
        pc_overflow = 0;
        clk = 0;

        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("terminator_tb.vcd");
        $dumpvars(0, terminator_tb);

        #10
        
        halt_instruction = 1;
        #5

        halt_instruction = 0; decode = 1;
        #5

        decode = 0; halt_instruction = 1;
        #10

        halt_instruction = 0;
        #10



        stack_overflow = 1;
        #10

        stack_overflow = 0;
        #10



        instruction_end = 1;
        #5

        instruction_end = 0; pc_overflow = 1;
        #5

        pc_overflow = 0; instruction_end = 0;
        #10

        instruction_end = 1;
        #10

        instruction_end = 0;
        #10

        $finish;
    end
endmodule