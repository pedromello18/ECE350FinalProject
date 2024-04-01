module counter(out, clk, reset);
    input clk, reset;
    output [3:0] out;

    wire in3, in2, in1, in0, q3, q2, q1, q0;

    assign in3 = (~q3 & q2 & q1 & q0) | (q3 & ~q2) | (q3 & ~q1) | (q3 & ~q0);
    assign in2 = (~q2 & q1 & q0) | (q2 & ~q1) | (q2 & ~q0);
    assign in1 = (q1 ^ q0);
    assign in0 = ~q0;

    dffe_ref BIT3(q3, in3, clk, 1'b1, reset); // MSB
    dffe_ref BIT2(q2, in2, clk, 1'b1, reset);
    dffe_ref BIT1(q1, in1, clk, 1'b1, reset);
    dffe_ref BIT0(q0, in0, clk, 1'b1, reset); // LSB

    assign out = {q3, q2, q1, q0};
endmodule