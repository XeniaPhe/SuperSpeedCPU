module half_adder(i0, i1, s, cout);
    input i0, i1;
    output s, cout;

    xor x(s, i0, i1);
    and a(cout, i0, i1);
endmodule