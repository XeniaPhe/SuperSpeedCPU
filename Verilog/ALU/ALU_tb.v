`include "ALU/ALU.v"

module ALU_tb;
    reg [19:0] i0, i1;
    reg [2:0] op_select;
    reg be_select;
    wire [19:0] s;
    wire e, cout;

    ALU al(i0, i1, op_select, be_select, s, cout, e);

    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0,ALU_tb);

        i0 = 20'd10; i1 = 20'd10; op_select = 3'd5; be_select = 1'b1;
        
    end

endmodule