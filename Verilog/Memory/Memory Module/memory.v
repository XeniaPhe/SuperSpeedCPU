`include "Memory/RAM/ram.v"
`include "Registers/10 Bit Register/ten_bit_register.v"

module memory(
    input [9:0] addr, PC
    input [19:0] write,
    input clk, wr_select,
    output [19:0] read, inst);

    wire wr_select_n;
    not n2(wr_select_n, wr_select);

    ram data_memory(addr, write, clk, wr_select, wr_select_n, read);

    wire clk_n, mar_q;
    not n1(clk_n, clk);

    ten_bit_register mar(PC, clk_n, 1, mar_q);

    ram instruction_memory(mar_q, 0, 0, 0, 1, inst);

    reg reset;

    initial begin
        reset = 0;
        #10


    end
endmodule