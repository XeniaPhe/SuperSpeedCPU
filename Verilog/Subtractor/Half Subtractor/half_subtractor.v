module half_subtractor(
    input i0, i1,
    output d, bout);

    assign d = i0 ^ i1;
    assign bout = ~i0 & i1;
endmodule