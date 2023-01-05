`include "Subtractor/20 Bit Subtractor/twenty_bit_subtractor.v"

module twenty_bit_subtractor_tb;
    reg [19:0] i0, i1;
    wire [19:0] d;
    wire bout;

    twenty_bit_subtractor subtractor(i0, i1, d, bout);

    initial begin
        $dumpfile("twenty_bit_subtractor_tb.vcd");
        $dumpvars(0,twenty_bit_subtractor_tb);

        i0 = 20'd0; i1 = 20'd0;
        #1

        i0 = 20'd0; i1 = 20'd1;
        #1

        i0 = 20'd1; i1 = 20'd0;
        #1

        i0 = 20'd110; i1 = 20'd110;
        #1

        i0 = 20'd72; i1 = 20'd27;
    end
endmodule