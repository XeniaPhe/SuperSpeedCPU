`timescale 1ns/1ns
`include "Memory/Memory Module/memory.v"

module memory_tb;
    reg [9:0] addr, PC;
    reg [19:0] write;
    reg clk, wr_select;
    wire [19:0] read, inst;

    memory #(.INSTRUCTIONS({20'h01234, 20'h56789, 20'hABCDE, 20'hF06CC, {1020{20'd0}}})) 
    mem (.addr(addr), .PC(PC), .write(write), .clk(clk), .wr_select(wr_select), .read(read), .inst(inst));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("memory_tb.vcd");
        $dumpvars(0,memory_tb);

        addr = 0; PC = 0; write = 1234; wr_select = 0;
        #5

        addr = 1; PC = 1; wr_select = 1;
        #5

        wr_select = 0;
        #5

        addr = 2; PC = 2; write = 9876; wr_select = 1;
        #5

        wr_select = 0;
        #5

        addr = 3; PC = 3; write = 10000;
        #5

        addr = 4; PC = 4; write = 5; wr_select = 1;
        #5

        wr_select = 0;
        #5

        addr = 5; PC = 5;
        #5

        $finish;
    end
endmodule