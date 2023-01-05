`include "twenty_bit_bitwise_xor.v"

module twenty_bit_bitwise_xor_tb;

    reg [19:0] i0, i1;
    wire [19:0] s;

    twenty_bit_bitwise_xor bwxor(i0, i1, s);

    initial begin
        $dumpfile("twenty_bit_bitwise_xor_tb.vcd");
        $dumpvars(0,twenty_bit_bitwise_xor_tb);

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
        #1

        i0 = 20'b11111111111111111111;
        i1 = 20'b00000000000000000000;
    end
endmodule