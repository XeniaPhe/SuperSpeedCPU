`include "equality_comparator.v"

module equality_comparator_tb;
    reg [19:0] i0, i1;
    reg be_select;
    wire s;

    equality_comparator comp(i0, i1, be_select, s);

    initial begin
        $dumpfile("equality_comparator_tb.vcd");
        $dumpvars(0, equality_comparator_tb);

        i0 = 20'd0; i1 = 20'd0; be_select = 0;
        #1

        i0 = 20'd0; i1 = 20'd1; be_select = 0;
        #1

        i0 = 20'd1; i1 = 20'd0; be_select = 0;
        #1

        i0 = 20'd111; i1 = 20'd111; be_select = 1;
        #1

        i0 = 20'd0; i1 = 20'd5; be_select = 1;
        #1

        i0 = 20'd49; i1 = 20'd50; be_select = 1;
    end

endmodule