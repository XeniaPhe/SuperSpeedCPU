module next_state(
    input alu, ld, st, push, pop, jump, be, s2, s1, s0,
    output s2_n, s1_n, s0_n);

    assign s0_n = (~s2) & (~s0) & ((~s1) | (s1 & (alu | jump | be)));
    assign s1_n = (~s2) & (((~s1) & s0) | (((~s0) & s1) & (alu | jump | be)));
    assign s2_n = (~s2) & s1 & (s0 | ((~s0) & (ld | st | push | pop)));
endmodule