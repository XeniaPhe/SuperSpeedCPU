`timescale 1ns/1ns
`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"

module rising_edge_triggered_d_flipflop_tb;
    reg d, w, clk, reset;
    wire q;

    rising_edge_triggered_d_flipflop flipflop(d, w, clk, reset, q);

    initial begin
        clk = 0;
        reset = 1;
        #1
        reset = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("rising_edge_triggered_d_flipflop_tb.vcd");
        $dumpvars(0, rising_edge_triggered_d_flipflop_tb);

        d = 1; w = 0;
        #10;

        d = 1; w = 0;
        #10;

        d = 1; w = 1;
        #10;

        d = 0; w = 1;
        #10;

        d = 0; w = 1;
        #10;

        d = 1; w = 1; reset = 1;
        #10;

        d = 0; w = 0; reset = 0;
        #10;

        d = 0; w = 0;
        #10;

        d = 1; w = 1;
        #10;

        d = 1; w = 1; reset = 1;
        #10;

        d = 1; w = 1; reset = 0;
        #10

        $finish;
    end
endmodule