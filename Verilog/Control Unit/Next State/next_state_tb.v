`include "Control Unit/Next State/next_state.v"

module next_state_tb;
    reg alu, ld, st, push, pop, jump, be, s2, s1, s0;
    wire s2_n, s1_n, s0_n;

    next_state next(alu, ld, st, push, pop, jump, be, s2, s1, s0, s2_n, s1_n, s0_n);

    initial begin
        $dumpfile("next_state_tb.vcd");
        $dumpvars(0, next_state_tb);

        alu = 0;
        ld = 0;
        st = 0;
        push = 0;
        pop = 0;
        jump = 0;
        be = 0;
        s2 = 0;
        s1 = 0;
        s0 = 0;

        #5

        alu = 1;
        #5

        alu = 0; ld = 1;
        #5

        ld = 0; st = 1;
        #5

        st = 0; push = 1;
        #5

        push = 0; pop = 1;
        #5

        pop = 0; jump = 1;
        #5

        jump = 0; be = 1;
        #5

        s0 = 1;
        #5

        be = 0; jump = 1;
        #5

        jump = 0; pop = 1;
        #5

        pop = 0; push = 1;
        #5

        push = 0; st = 1;
        #5

        st = 0; ld = 1;
        #5

        ld = 0; alu = 1;
        #5

        s0 = 0; s1 = 1;
        #5

        alu = 0; ld = 1;
        #5

        ld = 0; st = 1;
        #5

        st = 0; push = 1;
        #5

        push = 0; pop = 1;
        #5

        pop = 0; jump = 1;
        #5

        jump = 0; be = 1;
        #5

        s0 = 1;
        #5

        be = 0; jump = 1;
        #5

        jump = 0; pop = 1;
        #5

        pop = 0; push = 1;
        #5

        push = 0; st = 1;
        #5

        st = 0; ld = 1;
        #5

        ld = 0; alu = 1;
        #5

        s0 = 0; s1 = 0; s2 = 1;
        #5

        alu = 0; ld = 1;
        #5

        ld = 0; st = 1;
        #5

        st = 0; push = 1;
        #5

        push = 0; pop = 1;
        #5

        pop = 0; jump = 1;
        #5

        jump = 0; be = 1;
        #5
        
        $finish;
    end
endmodule