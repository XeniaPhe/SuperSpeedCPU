`timescale 1ns/1ns
`include "ALU/ALU.v"

module ALU_tb;
    reg [19:0] i0, i1;
    reg [2:0] op_select;
    reg be_select;
    wire [19:0] s;
    wire e, cout;

    ALU alu(i0, i1, op_select, be_select, s, cout, e);

    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0,ALU_tb);

        #10
        op_select = 3'b000;
        i0 = 20'd10;
        i1 = 20'd10;
        be_select = 1'b1;

        #10
        op_select = 3'b000;
        i0 = 20'd10;
        i1 = 20'd11;
        be_select = 1'b1;

        #10
        op_select = 3'b000;
        i0 = 20'd0;
        i1 = 20'd0;
        be_select = 1'b0;

        #10
        op_select = 3'b000;
        i0 = 20'b11111111111111111111;
        i1 = 20'd1;
        be_select = 1'b0;

        #10
        op_select = 3'b001;
        i0 = 20'd10;
        i1 = 20'd10;
        be_select = 1'b1;

        #10
        op_select = 3'b001;
        i0 = 20'd0;
        i1 = 20'd0;
        be_select = 1'b1;

        #10
        op_select = 3'b001;
        i0 = 20'd100;
        i1 = 20'd150;
        be_select = 1'b0;

        #10
        op_select = 3'b010;
        i0 = 20'b11111111111111111111;
        i1 = 20'b11111111111111111111;
        be_select = 1'b1;

        #10
        op_select = 3'b010;
        i0 = 20'h00ABC;
        i1 = 20'h00ABC;
        be_select = 1'b1;

        #10
        op_select = 3'b011;
        i0 = 20'd0;
        i1 = 20'd10;
        be_select = 1'b1;

        #10
        op_select = 3'b011;
        i0 = 20'd0;
        i1 = 20'd0;
        be_select = 1'b1;

        #10
        op_select = 3'b011;
        i0 = 20'b11111111111111111111;
        i1 = 20'b11111111111111111111;
        be_select = 1'b1;

        #10
        op_select = 3'b100;
        i0 = 20'd1550;
        i1 = 20'd1550;
        be_select = 1'b1;

        #10
        op_select = 3'b100;
        i0 = 20'd0;
        i1 = 20'd72;
        be_select = 1'b1;

        #10
        op_select = 3'b100;
        i0 = 20'hA0B0C;
        i1 = 20'h0D0E0;
        be_select = 1'b1;
    end

endmodule