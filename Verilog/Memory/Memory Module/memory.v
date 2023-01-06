`include "Memory/RAM/ram.v"
`include "Registers/10 Bit Register/ten_bit_register.v"

module memory(
    input [9:0] addr, PC
    input [19:0] write,
    input clk, wr_select, reset,
    output [19:0] read, inst);

    wire wr_select_n;
    not n2(wr_select_n, wr_select);

    ram data_memory(addr, write, clk, wr_select, wr_select_n, read);


    wire clk_n;
    not n1(clk_n, clk);

    ten_bit_register mar()
endmodule