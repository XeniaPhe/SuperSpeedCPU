`include "Registers/20 Bit Register/twenty_bit_register.v"
`include "Control Unit/Instruction Decoder/instruction_decoder.v"
`include "Control Unit/Signal Generator/signal_generator.v"
`include "Control Unit/Stack Pointer/stack_pointer.v"
`include "Control Unit/State Manager/state_manager.v"
`include "Control Unit/Terminator/terminator.v"

module control_unit(
    input [19:0] instruction, pc_overflow, clk,
    output fetch, alu_control, reg_read, reg_write, mem_read, mem_write, 
    pc_read, pc_write, imm, reg_w_select, pc_r_select, pc_w_select, be_select,
    output [2:0] alu_select,
    output [3:0] dr, sr1, sr2,
    output [19:0] imm_offset,
    output [9:0] addr);

    

endmodule