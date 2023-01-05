`include "Registers/Register File/register_file.v"

module register_file_tb;
    reg [19:0] write;
    reg [3:0] w_select, r1_select, r2_select;
    reg clk, w, reset;
    wire [19:0] read1, read2;

    register_file regfile(write, w_select, r1_select, r2_select,
     clk, w, reset, read1, read2);

     initial begin
        clk = 0;
        reset = 1;
        #5

        reset = 0;
        forever #5 clk = ~clk;
     end

     initial begin
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0,register_file_tb);

        write = 20'd123; w_select = 4'd0; w = 1;
        r1_select = 4'd0; r2_select = 4'd0;
        #10

        write = 20'd1234; w_select = 4'd1; w = 1;
        r1_select = 4'd0; r2_select = 4'd1;
        #10

        write = 20'd12345; w_select = 4'd2; w = 1;
        r1_select = 4'd1; r2_select = 4'd2;
        #10

        write = 20'd111; w_select = 4'd3; w = 0;
        r1_select = 4'd2; r2_select = 4'd3;
        #10

        $finish;
     end

endmodule