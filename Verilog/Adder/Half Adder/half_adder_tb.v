`include "Adder/Half Adder/half_adder.v"

module half_adder_tb;
    reg a, b;
    wire s, cout;

    half_adder ha(a, b, s, cout);

    initial begin
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0,half_adder_tb);

        a = 0; b = 0;
        #1

        a = 0; b = 1;
        #1

        a = 1; b = 0;
        #1

        a = 1; b = 1;
    end
endmodule