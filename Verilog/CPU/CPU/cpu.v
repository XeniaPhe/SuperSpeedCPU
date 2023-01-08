`timescale 1ns/1ns
`include "Memory/Memory Module/memory.v"
`include "Registers/Register File/register_file.v"
`include "CPU/Program Counter/program_counter.v"
`include "ALU/ALU.v"
`include "Control Unit/Control Unit/control_unit.v"

module cpu#(
    parameter [0:20479] INSTRUCTIONS = {1024{20'd0}}
);
    reg clk;

    //Control Unit
    wire fetch, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, imm, reg_w_select, pc_r_select, pc_w_select, be_select;
    wire [2:0] alu_select;
    wire [3:0] dr, sr1, sr2;
    wire [19:0] imm_offset;
    wire [9:0] addr;

    //Program Counter
    wire [9:0] PC;
    wire pc_overflow;

    //Register File
    wire [19:0] read1, read2;

    //Memory
    wire [19:0] mem_q, inst;

    //Decrementer
    wire [9:0] PC_decremented;
    wire ignore;

    //ALU
    wire [19:0] al_q;
    wire cout, e;

    control_unit cu(inst, pc_overflow, clk, fetch, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, 
    pc_write, imm, reg_w_select, pc_r_select, pc_w_select, be_select, alu_select, dr, sr1, sr2, imm_offset, addr);

    program_counter pc(pc_w_select ? (e ? addr : PC) : (al_q), fetch, pc_write, clk, PC, pc_overflow);

    register_file temp(reg_w_select ? al_q : mem_q, dr, sr1, sr2, clk, reg_write, read1, read2);

    memory #(.INSTRUCTIONS(INSTRUCTIONS)) mem(.addr(addr), .PC(PC), .write(read1), .clk(clk), .wr_select(mem_write), .read(mem_q), .inst(inst));

    ten_bit_decrementer decr(PC, PC_decremented, ignore);

    ALU al_unit(pc_r_select ? ({10'd0, PC_decremented}) : (read1), imm ? (imm_offset) : (read2), alu_select, be_select, al_q, cout, e);

    initial begin
        clk = 0;

        forever #1 clk = ~clk;
    end
endmodule