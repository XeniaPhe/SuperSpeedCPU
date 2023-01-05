`include "../Half Adder/half_adder.v"

module full_adder(i0, i1, cin, s, cout);
    input i0, i1, cin;
    output s, cout;

    wire s1, c1, c2;

    half_adder ha1(i0, i1, s1, c1);
    half_adder ha2(cin, s1, s, c2);

    or o(cout, c1, c2);
endmodule