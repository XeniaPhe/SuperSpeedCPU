`include "ten_bit_incrementer.v"

module ten_bit_incrementer_tb;
    reg [9:0] a;
    wire [9:0] s;
    wire o;

    ten_bit_incrementer incr(a, s, o);

    initial begin
        $dumpfile("ten_bit_incrementer_tb.vcd");
        $dumpvars(0, ten_bit_incrementer_tb);

        a = 10'd0;
        #1

        a = 10'd1;
        #1

        a = 10'd2;
        #1

        a = 10'b1111111110;
        #1

        a = 10'b1111111111;
    end


endmodule