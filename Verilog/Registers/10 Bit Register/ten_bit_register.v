`ifndef RETDFF
`include "Latches/Rising Edge Triggered D Flip-Flop/rising_edge_triggered_d_flipflop.v"
`endif

module ten_bit_register#(
    parameter [9:0] INIT = 10'd0
)(
    input [9:0] d,
    input clk, w,
    output reg [9:0] q);

    initial begin
        q = INIT;
    end

    always @(posedge clk) begin
        if(w)
            q <= d;
    end
endmodule