`include "Subtractor/Half Subtractor/half_subtractor.v"

module half_subtractor_tb;

    reg i0, i1;
    wire d, bout;

    half_subtractor hs(i0, i1, d, bout);

    initial begin
        $dumpfile("half_subtractor_tb.vcd");
        $dumpvars(0,half_subtractor_tb);

        i0 = 0; i1 = 0;
        #1

        i0 = 0; i1 = 1;
        #1

        i0 = 1; i1 = 0;
        #1

        i0 = 1; i1 = 1;
    end

endmodule