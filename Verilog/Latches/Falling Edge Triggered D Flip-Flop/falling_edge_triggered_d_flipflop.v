module falling_edge_triggered_d_flipflop(
    input d, w, clk,
    output reg q);

    initial begin
        q = 0;
    end

    always @(negedge clk) begin
        if(w)
            q <= d;
    end
endmodule