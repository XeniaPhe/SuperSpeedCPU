`include "ten_bit_decrementer.v"

module ten_bit_decrementer_tb;

    reg [9:0] a;
    wire [9:0] s;
    wire o;

    ten_bit_decrementer decr(a, s, o);

    initial begin
        $dumpfile("ten_bit_decrementer_tb.vcd");
        $dumpvars(0,ten_bit_decrementer_tb);

        a = 10'd0;
        #1

        a = 10'd1;
        #1

        a = 10'd36;
        #1

        a = 10'b1111111110;
        #1

        a = 10'b1111111111;
    end
endmodule