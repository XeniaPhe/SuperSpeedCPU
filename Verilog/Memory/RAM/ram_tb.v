`timescale 1ns/1ns
`include "Memory/RAM/ram.v"

module ram_tb;
    reg [9:0] addr;
    reg [19:0] write;
    reg clk, str, ld;
    wire [19:0] read;

    ram mem(addr, write, clk, str, ld, read);

    initial begin
        clk = 0;
        #10
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("ram_tb.vcd");
        $dumpvars(0,ram_tb);

        ld = 1;
        addr = 0; write = 101; str = 0;
        #10
        str = 1;
        #10

        ld = 0;
        #10

        ld = 1;
        addr = 1; write = 202;
        #10

        addr = 2; write = 303;
        #10

        addr = 3; write = 404;
        #10

        addr = 4; write = 505;
        #10

        addr = 3;
        str = 0;
        #10

        addr = 2;
        #10
        
        $finish;
    end
endmodule