`include "Registers/20 Bit Register/twenty_bit_register.v"
`include "Control Unit/Instruction Decoder/instruction_decoder.v"
`include "Control Unit/Signal Generator/signal_generator.v"
`include "Control Unit/Stack Pointer/stack_pointer.v"
`include "Control Unit/State Manager/state_manager.v"
`include "Control Unit/Terminator/terminator.v"

module control_unit(
    input [19:0] instruction, 
    input pc_overflow, clk,
    output fetch, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, imm, reg_w_select, pc_r_select, pc_w_select, be_select,
    output [2:0] alu_select,
    output [3:0] dr, sr1, sr2,
    output [19:0] imm_offset,
    output [9:0] addr);

    wire [19:0] _instruction; //Instruction Register's output
    wire alu, ld, st, push, pop, jump, be, halt; //Instruction Decoder's output
    wire [9:0] _addr; //Instruction Decoder's output
    wire s2, s1, s0; //State Manager's output
    wire instruction_end, decode, push_s, pop_s; //Signal Generator's output
    wire [9:0] SP; //Stack Pointer's output
    wire stack_overflow; //Stack Pointer's output
    wire halted; //Terminator's output
    wire stack_operation;

    twenty_bit_register instruction_register(instruction, decode, 1'b1, _instruction);

    instruction_decoder decoder(_instruction, alu_select, alu, imm, ld, st, push, pop, jump, be, be_select, halt, dr, sr1, sr2, imm_offset, _addr);

    state_manager manager(alu, ld, st, push, pop, jump, be, clk, s2, s1, s0);

    signal_generator generator(halted, alu, ld, st, push, pop, jump, be, s2, s1, s0, instruction_end, 
    fetch, decode, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, push_s, pop_s);

    stack_pointer sp(push_s, pop_s, clk, SP, stack_overflow);

    terminator term(decode, halt, stack_overflow, instruction_end, pc_overflow, clk, halted);

    or(stack_operation, push, pop);

    assign reg_w_select = alu;
    assign pc_r_select = jump;
    assign pc_w_select = be;
    assign addr = stack_operation ? SP : _addr;
endmodule