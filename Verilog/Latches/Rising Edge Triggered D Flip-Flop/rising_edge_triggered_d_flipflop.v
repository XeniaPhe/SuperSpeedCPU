module rising_edge_triggered_d_flipflop(
    input d, w, clk, reset,
    output reg q);

    always @(posedge clk or reset) begin
        if(reset & ~clk) begin
            q <= 0;
        end else if(w) begin
            q <= d;
        end
    end
endmodule