`include "Registers/20 Bit Register/twenty_bit_register.v"

module register_file(
    input [19:0] write,
    input [3:0] w_select, r1_select, r2_select,
    input clk, w, reset,
    output reg [19:0] read1, read2);
    
    genvar i;

    generate
        for(i = 0; i < 16; i = i + 1) begin
            wire wi = w_select == i;
            wire [19:0] readi;
            twenty_bit_register regi(write, clk, wi, reset, readi);

            always @(*) begin
                if(r1_select == i)
                    read1 <= readi;
                if(r2_select == i)
                    read2 <= readi;
            end
        end
    endgenerate
endmodule