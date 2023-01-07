`define RETDFF

module rising_edge_triggered_d_flipflop(
    input d, w, clk,
    output reg q);

    initial begin
        q = 0;
    end

    always @(posedge clk) begin
        if(w)
            q <= d;
    end
endmodule