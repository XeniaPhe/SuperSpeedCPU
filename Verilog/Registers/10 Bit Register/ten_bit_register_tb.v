`timescale 1ns/1ns
`include "Registers/10 Bit Register/ten_bit_register.v"

module ten_bit_register_tb;
    reg [9:0] d;
    reg clk, w;
    wire [9:0] q;

    ten_bit_register #(.INIT(10'b1111100000)) regs(.d(d), .clk(clk), .w(w), .q(q));

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("ten_bit_register_tb.vcd");
        $dumpvars(0, ten_bit_register_tb);

        d = 10'd45; w = 1;
        #10

        d = 10'd54; w = 1;
        #10

        d = 10'd100; w = 0;
        #10

        d = 10'd101; w = 1;
        #10

        d = 10'd105; w = 1;
        #10

        d = 10'd0; w = 0;
        #10

        d = 10'd0; w = 1;
        #10

        $finish;
    end

endmodule