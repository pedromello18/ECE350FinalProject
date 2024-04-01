module lls_1(out, s, A);
    input s;
    input [31:0] A;
    output [31:0] out;

    mux_2 BIT0(out[0], s, A[0], 1'b0);
    mux_2 BIT1(out[1], s, A[1], A[0]);
    mux_2 BIT2(out[2], s, A[2], A[1]);
    mux_2 BIT3(out[3], s, A[3], A[2]);
    mux_2 BIT4(out[4], s, A[4], A[3]);
    mux_2 BIT5(out[5], s, A[5], A[4]);
    mux_2 BIT6(out[6], s, A[6], A[5]);
    mux_2 BIT7(out[7], s, A[7], A[6]);
    mux_2 BIT8(out[8], s, A[8], A[7]);
    mux_2 BIT9(out[9], s, A[9], A[8]);
    mux_2 BIT10(out[10], s, A[10], A[9]);
    mux_2 BIT11(out[11], s, A[11], A[10]);
    mux_2 BIT12(out[12], s, A[12], A[11]);
    mux_2 BIT13(out[13], s, A[13], A[12]);
    mux_2 BIT14(out[14], s, A[14], A[13]);
    mux_2 BIT15(out[15], s, A[15], A[14]);
    mux_2 BIT16(out[16], s, A[16], A[15]);
    mux_2 BIT17(out[17], s, A[17], A[16]);
    mux_2 BIT18(out[18], s, A[18], A[17]);
    mux_2 BIT19(out[19], s, A[19], A[18]);
    mux_2 BIT20(out[20], s, A[20], A[19]);
    mux_2 BIT21(out[21], s, A[21], A[20]);
    mux_2 BIT22(out[22], s, A[22], A[21]);
    mux_2 BIT23(out[23], s, A[23], A[22]);
    mux_2 BIT24(out[24], s, A[24], A[23]);
    mux_2 BIT25(out[25], s, A[25], A[24]);
    mux_2 BIT26(out[26], s, A[26], A[25]);
    mux_2 BIT27(out[27], s, A[27], A[26]);
    mux_2 BIT28(out[28], s, A[28], A[27]);
    mux_2 BIT29(out[29], s, A[29], A[28]);
    mux_2 BIT30(out[30], s, A[30], A[29]);
    mux_2 BIT31(out[31], s, A[31], A[30]);

endmodule