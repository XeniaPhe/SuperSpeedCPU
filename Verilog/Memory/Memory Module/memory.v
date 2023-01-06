`include "Memory/RAM/ram.v"
`include "Registers/10 Bit Register/ten_bit_register.v"

module memory#(
    parameter [0:20479] INSTRUCTIONS = {1024{20'd0}}
)(
    input [9:0] addr, PC,
    input [19:0] write,
    input clk, wr_select,
    output [19:0] read, inst);

    wire wr_select_n, clk_n;

    not n1(clk_n, clk);
    not n2(wr_select_n, wr_select);

    ram data_memory(addr, write, clk, wr_select, wr_select_n, read);

    wire [9:0] mar_q;
    
    ten_bit_register mar(PC, clk_n, 1'b1, mar_q);
    ram #(.INIT(INSTRUCTIONS)) instruction_memory(.addr(mar_q), .write(20'd0), .clk(1'b0), .str(1'b0), .ld(1'b1), .read(inst));
endmodule