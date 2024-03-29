`include "Bitwise And/twenty_bit_bitwise_and.v"

module twenty_bit_bitwise_and_tb;

    reg [19:0] i0, i1;
    wire [19:0] s;

    twenty_bit_bitwise_and bwand(i0, i1, s);

    initial begin
        $dumpfile("twenty_bit_bitwise_and_tb.vcd");
        $dumpvars(0,twenty_bit_bitwise_and_tb);

        i0 = 20'b00000000000000000000;
        i1 = 20'b00000000000000000000;
        #1

        i0 = 20'b00000000000001011111;
        i1 = 20'b00000000000000000000;
        #1

        i0 = 20'b11000000000000000011;
        i1 = 20'b11000000000000000011;
        #1

        i0 = 20'b11111111111111111111;
        i1 = 20'b11111111111111111111;
    end
endmodule