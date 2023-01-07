module signal_generator(
    input halted, alu, ld, st, push, pop, jump, be, s2, s1, s0,
    output instruction_end, fetch, decode, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, push_s, pop_s);

    assign instruction_end = s2 & (~s1) & (~s0) & (~halted);
    assign fetch = (~s2) & (~s1) & (~s0) & (~halted);
    assign decode = (~s2) & (~s1) & s0 & (~halted);
    assign alu_control = (~s2) & s1 & s0 & (~halted);
    assign reg_read = (~s2) & s1 & (~s0) & (alu | st | push | be) & (~halted);
    assign reg_write = s2 & (~s1) & (~s0) & (alu | ld | pop) & (~halted);
    assign mem_read = (~s2) & s1 & (~s0) & (ld | pop) & (~halted);
    assign mem_write = s2 & (~s1) & (~s0) & (st | push) & (~halted);
    assign pc_read = (~s2) & s1 & (~s0) & jump & (~halted);
    assign pc_write = s2 & (~s1) & (~s0) & (jump | be) & (~halted);
    assign push_s = s2 & (~s1) & (~s0) & push & (~halted);
    assign pop_s = (~s2) & s1 & (~s0) & pop & (~halted);
endmodule