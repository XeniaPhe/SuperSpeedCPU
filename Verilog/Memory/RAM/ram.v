module ram#(
    parameter [0:20479] INIT = {1024{20'd0}}
)(
    input [9:0] addr,
    input [19:0] write,
    input clk, str, ld,
    output reg [19:0] read);

    reg [19:0] mem [0:1023];

    integer i;
    initial begin
        for(i = 0; i < 1024; i = i + 1) begin
            mem[i] = INIT[(20 * i) +: 20];
        end
    end

    always @(*) begin
        read = ld ? mem[addr] : 20'dx;
    end

    always @(posedge clk) begin
        if(str) begin
            mem[addr] <= write;
        end
    end
endmodule