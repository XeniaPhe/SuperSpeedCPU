`timescale 1ns/1ns
`include "Control Unit/Terminator/terminator.v"

module terminator_tb;


    initial begin
        clk = 0;

        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("terminator_tb.vcd");
        $dumpvars(0,terminator_tb);
    end
endmodule