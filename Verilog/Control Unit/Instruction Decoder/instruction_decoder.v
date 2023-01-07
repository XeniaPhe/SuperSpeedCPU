module instruction_decoder(
    input [19:0] instruction,
    output reg [2:0] alu_select,
    output reg alu, is_imm, ld, st, push, pop, jump, be, be_select, halt,
    output reg [3:0] dr, sr1, sr2,
    output reg [19:0] imm,
    output reg [9:0] addr);

    wire [4:0] opcode = instruction[0+:5];
    wire [9:0] zero_nine = instruction[0+:10];
    wire [6:0] zero_six = instruction[0+:7];

    wire [3:0] zero_three = instruction[0+:4];
    wire [3:0] four_seven = instruction[4+:4];
    wire [3:0] seven_ten = instruction[7+:4];
    wire [3:0] eight_eleven = instruction[8+:4];
    wire [3:0] ten_thirteen = instruction[10+:4];
    wire [3:0] eleven_fourteen = instruction[11+:4];

    reg alu_not_imm;

    reg [1:0] dr_select;
    reg [2:0] sr1_select;

    always @(instruction) begin
        dr_select = 2'd0;
        alu_select = 3'd0;
        alu = 0;
        alu_not_imm = 0;
        is_imm = 0;
        ld = 0;
        st = 0;
        push = 0;
        pop = 0;
        jump = 0;
        be = 0;
        be_select = 0;
        halt = 0;
        dr = 4'd0;
        sr1 = 4'd0;
        sr2 = 4'd0;
        imm = 20'd0;
        addr = 10'd0;

        if(opcode == 0) begin
            halt = 1;
        end else if (opcode > 0 && opcode < 11) begin
            alu = 1;

            if(opcode % 2 == 0)
                is_imm = 1;
            else
                alu_not_imm = 1;

            alu_select[2] = opcode > 8;
            alu_select[1] = (opcode > 4 && opcode < 9);
            alu_select[0] = (opcode == 3 || opcode == 4 || opcode == 7 || opcode == 8);
        end else if (opcode > 10 && opcode < 18) begin
            case(opcode)
                5'd11 : ld = 1;
                5'd12 : st = 1;
                5'd13 : push = 1;
                5'd14 : pop = 1;
                5'd15 : jump = 1;
                default : be = 1;
            endcase
        end

        dr_select[0] = ld | pop;
        dr_select[1] = pop | alu_not_imm;

        sr1_select[0] = st | alu_not_imm;
        sr1_select[1] = alu;
        sr1_select[2] = push;

        case(dr_select)
            2'd0 : dr = eleven_fourteen;
            2'd1 : dr = ten_thirteen;
            2'd2 : dr = eight_eleven;
            2'd3 : dr = zero_three;
        endcase

        case(sr1_select)
            3'd0 : sr1 = eleven_fourteen;
            3'd1 : sr1 = ten_thirteen;
            3'd2 : sr1 = seven_ten;
            3'd3 : sr1 = four_seven;
            3'd4 : sr1 = zero_three;
        endcase

        if(alu_not_imm)
            sr2 = zero_three;
        else
            sr2 = seven_ten;

        if(be)
            addr = {3'b000, zero_six};
        else
            addr = zero_nine;

        imm = {{13{zero_six[6]}}, zero_six};
    end

endmodule