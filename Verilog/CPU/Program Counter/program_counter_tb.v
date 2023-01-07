`timescale 1ns/1ns
`include "CPU/Program Counter/program_counter.v"

module program_counter_tb;
    reg [9:0] addr;
    reg fetch, pc_write, clk;
    wire [9:0] PC;
    wire pc_overflow;

    program_counter pc(addr, fetch, pc_write, clk, PC, pc_overflow);

    initial begin
        clk = 0;
        addr = 0;
        pc_write = 0;

        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("program_counter_tb.vcd");
        $dumpvars(0,program_counter_tb);

        fetch = 1;
        #2

        fetch = 0; pc_write = 1; addr = 10'd50;
        #2

        fetch = 1; pc_write = 0;
        #2

        fetch = 0; pc_write = 1; addr = 10'd100;
        #2

        fetch = 1; pc_write = 0;
        #10

        fetch = 0; pc_write = 1; addr = 10'd1015;
        #2

        fetch = 1; pc_write = 0;
        #50

        $finish;
    end
endmodule