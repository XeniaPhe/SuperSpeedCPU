`timescale 1ns/1ns
`include "Control Unit/State Manager/state_manager.v"

module state_manager_tb;
    reg alu, ld, st, push, pop, jump, be, clk;
    wire s2, s1, s0;

    state_manager manager(alu, ld, st, push, pop, jump, be, clk, s2, s1, s0);
    
    initial begin
        alu = 0;
        ld = 0;
        st = 0;
        push = 0;
        pop = 0;
        jump = 0;
        be = 0;
        clk = 0;

        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("state_manager_tb.vcd");
        $dumpvars(0,state_manager_tb);

        alu = 1;
        #10

        alu = 0; ld = 1;
        #8

        ld = 0; st = 1;
        #8

        st = 0; push = 1;
        #8

        push = 0; pop = 1;
        #8

        pop = 0; jump = 1;
        #10

        jump = 0; be = 1;
        #10

        $finish;
    end
endmodule