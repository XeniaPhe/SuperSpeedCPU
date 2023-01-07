`include "Registers/10 Bit Register/ten_bit_register.v"
`include "Adder/Incrementer/ten_bit_incrementer.v"

module program_counter(
    input [9:0] addr,
    input fetch, pc_write, clk,
    output [9:0] PC,
    output pc_overflow);

    wire w_enabled;
    wire [9:0] pc_q, incr_q;

    or(w_enabled, fetch, pc_write);

    ten_bit_register pc(fetch ? incr_q : addr, clk, w_enabled, pc_q);
    
    genvar i;
    generate
        for(i = 0; i < 10; i = i + 1) begin
            and(PC[i], pc_q[i], 1'b1);
        end
    endgenerate

    ten_bit_incrementer incr(pc_q, incr_q, pc_overflow);
endmodule