primitive d_latch(q, d, clk, clr);
    output reg q;
    input d, clk, clr;

    table
        ? 	0   0   :   ?   :	-;
        0   0   1	:   ?   :   0;
        0   1   ?	:   ?   :   0;
        1   0   1	:   ?   :   0;
        1   1   ?	:   ?   :   1;
    endtable
endprimitive