`timescale 1ns/1ns
`include "Latches/D Latch/d_latch.v"

module d_latch_tb;
    reg d, clk, clr;
    wire q;

    d_latch latch(q, d, clk, clr);

    initial begin
        clk = 1;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("d_latch_tb.vcd");
        $dumpvars(0,d_latch_tb);

        d = 1; clr = 0;
        #10

        d = 0; clr = 0;
        #10

        d = 1; clr = 0;
        #10

        d = 1; clr = 1;
        #10

        d = 0; clr = 1;
        #10

        d = 0; clr = 1;
        #10

        d = 1; clr = 1;
        #10

        d = 0; clr = 0;
        #10

        d = 0; clr = 0;
        #10

        d = 1; clr = 0;
        #10

        d = 0; clr = 1;
        #10

        $finish;
    end
endmodule