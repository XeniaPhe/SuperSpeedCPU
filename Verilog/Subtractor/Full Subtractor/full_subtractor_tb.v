`include "full_subtractor.v"

module full_subtractor_tb;
    reg i0, i1, bin;
    wire d, bout;

    full_subtractor fs(i0, i1, bin, d, bout);

    initial begin
        $dumpfile("full_subtractor_tb.vcd");
        $dumpvars(0, full_subtractor_tb);

        i0 = 0; i1 = 0; bin = 0;
        #1

        i0 = 0; i1 = 0; bin = 1;
        #1

        i0 = 0; i1 = 1; bin = 0;
        #1

        i0 = 1; i1 = 0; bin = 0;
        #1

        i0 = 0; i1 = 1; bin = 1;
        #1

        i0 = 1; i1 = 0; bin = 1;
        #1

        i0 = 1; i1 = 1; bin = 0;
        #1

        i0 = 1; i1 = 1; bin = 1;
    end

endmodule