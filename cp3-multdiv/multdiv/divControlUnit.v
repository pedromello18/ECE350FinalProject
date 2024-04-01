module divControlUnit(n_iter, newDiv, clk);
    output [4:0] n_iter;
    input newDiv, clk;

    wire in4, in3, in2, in1, in0, q4, q3, q2, q1, q0;

    assign in4 = (~(q4) & q3 & q2 & q1 & q0) | (q4 & ~(q3)) | (q4 & ~(q2)) | (q4 & ~(q1)) | (q4 & ~(q0));
    assign in3 = (~(q3) & q2 & q1 & q0) | (q3 & ~(q2)) | (q3 & ~(q1)) | (q3 & ~(q0));
    assign in2 = (~(q2) & q1 & q0) | (q2 & ~(q1)) | (q2 & ~(q0));
    assign in1 = (q1 ^ q0);
    assign in0 = ~q0;

    dffe_ref BIT4(q4, in4, clk, 1'b1, newDiv); // MSB
    dffe_ref BIT3(q3, in3, clk, 1'b1, newDiv);
    dffe_ref BIT2(q2, in2, clk, 1'b1, newDiv);
    dffe_ref BIT1(q1, in1, clk, 1'b1, newDiv);
    dffe_ref BIT0(q0, in0, clk, 1'b1, newDiv); // LSB

    assign n_iter = {q4, q3, q2, q1, q0};
endmodule