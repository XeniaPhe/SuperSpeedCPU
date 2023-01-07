`include "Control Unit/Signal Generator/signal_generator.v"

module signal_generator_tb;
    reg halted, alu, ld, st, push, pop, jump, be;
    reg [2:0] state;
    wire instruction_end, fetch, decode, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, push_s, pop_s;


    signal_generator generator(halted, alu, ld, st, push, pop, jump, be, state[2], state[1], state[0],
    instruction_end, fetch, decode, alu_control, reg_read, reg_write, mem_read, mem_write, pc_read, pc_write, push_s, pop_s);


    initial begin
        $dumpfile("signal_generator_tb.vcd");
        $dumpvars(0, signal_generator_tb);

        alu = 0;
        ld = 0;
        st = 0;
        push = 0;            
        pop = 0;
        jump = 0;
        be = 0;

        for(state = 3'd0; state < 3'd5; state = state + 3'd1) begin
            be = 0;
            halted = 1;
            #2
            
            halted = 0;
            #2

            alu = 1;
            #2

            alu = 0; ld = 1;
            #2

            ld = 0; st = 1;
            #2

            st = 0; push = 1;
            #2

            push = 0; pop = 1;
            #2

            pop = 0; jump = 1;
            #2

            jump = 0; be = 1;
            #2

            halted = 0;
        end

        $finish;
    end
endmodule