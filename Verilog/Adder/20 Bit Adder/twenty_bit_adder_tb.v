`include "Adder/20 Bit Adder/twenty_bit_adder.v"

module twenty_bit_adder_tb;
    reg [19:0] i0, i1;
    wire [19: 0] s;
    wire cout;

    twenty_bit_adder adder(i0, i1, s, cout);

    initial begin
        $dumpfile("twenty_bit_adder_tb.vcd");
        $dumpvars(0, twenty_bit_adder_tb);

        i0 = 20'd0; i1 = 20'd0;
        #1

        i0 = 20'd0; i1 = 20'd1;
        #1

        i0 = 20'd1; i1 = 20'd0;
        #1

        i0 = 20'd111; i1 = 20'd222;
        #1

        i0 = 20'd1000; i1 = 20'd1000;
    end

endmodule