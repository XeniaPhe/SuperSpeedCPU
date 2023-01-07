`include "Control Unit/Instruction Decoder/instruction_decoder.v"

module instruction_decoder_tb;
    reg [19:0] instruction;
    wire [2:0] alu_select;
    wire alu, is_imm, ld, st, push, pop, jump, be, be_select, halt;
    wire [3:0] dr, sr1, sr2;
    wire [19:0] imm;
    wire [9:0] addr;

    instruction_decoder decoder(instruction, alu_select, alu, is_imm, ld, 
    st, push, pop, jump, be, be_select, halt, dr, sr1, sr2, imm, addr);


    initial begin
        $dumpfile("instruction_decoder_tb.vcd");
        $dumpvars(0,instruction_decoder_tb);

        instruction = 20'h00000;
        #5

        instruction = 20'h08012;
        #5

        instruction = 20'h11A0A;
        #5

        instruction = 20'h18567;
        #5

        instruction = 20'h24488;
        #5

        instruction = 20'h28ABC;
        #5

        instruction = 20'h36F06;
        #5

        instruction = 20'h38F01;
        #5

        instruction = 20'h41184;
        #5

        instruction = 20'h48456;
        #5

        instruction = 20'h53C02;
        #5

        instruction = 20'h5A440;
        #5

        instruction = 20'h62820;
        #5

        instruction = 20'h6800B;
        #5

        instruction = 20'h7000C;
        #5

        instruction = 20'h78003;
        #5

        instruction = 20'h86F05;
        #5

        instruction = 20'h8F807;
        #5

        $finish;
    end
endmodule