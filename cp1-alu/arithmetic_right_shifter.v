module arithmetic_right_shifter(out, shamt, A);
    input [31:0] A;
    input [4:0] shamt;
    output [31:0] out;

    wire [31:0] w1, w2, w3, w4;

    ars_1 BY_ONE(w1, shamt[0], A);
    ars_2 BY_TWO(w2, shamt[1], w1);
    ars_4 BY_FOUR(w3, shamt[2], w2);
    ars_8 BY_EIGHT(w4, shamt[3], w3);
    ars_16 BY_SIXTEEN(out, shamt[4], w4);
endmodule