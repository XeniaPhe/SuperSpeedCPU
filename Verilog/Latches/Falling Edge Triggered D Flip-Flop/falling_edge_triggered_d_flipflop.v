module falling_edge_triggered_d_flipflop(
    input d, w, clk,
    output reg q);
    
    reg reset = 0;
    initial begin
        q = 0;
        #1 reset = 1; 
        //this makes sure the if block inside the always block won't be executed 
        //when the simulation is first run and the clock drops to 0 from x
    end

    always @(negedge clk) begin
        if(w & reset)
            q <= d;
    end
endmodule