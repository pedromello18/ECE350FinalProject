module bitwise_not(out, A);
    input [31:0] A;
    output [31:0] out;

    not BIT0(out[0], A[0]);
    not BIT1(out[1], A[1]);
    not BIT2(out[2], A[2]);
    not BIT3(out[3], A[3]);
    not BIT4(out[4], A[4]);
    not BIT5(out[5], A[5]);
    not BIT6(out[6], A[6]);
    not BIT7(out[7], A[7]);
    not BIT8(out[8], A[8]);
    not BIT9(out[9], A[9]);
    not BIT10(out[10], A[10]);
    not BIT11(out[11], A[11]);
    not BIT12(out[12], A[12]);
    not BIT13(out[13], A[13]);
    not BIT14(out[14], A[14]);
    not BIT15(out[15], A[15]);
    not BIT16(out[16], A[16]);
    not BIT17(out[17], A[17]);
    not BIT18(out[18], A[18]);
    not BIT19(out[19], A[19]);
    not BIT20(out[20], A[20]);
    not BIT21(out[21], A[21]);
    not BIT22(out[22], A[22]);
    not BIT23(out[23], A[23]);
    not BIT24(out[24], A[24]);
    not BIT25(out[25], A[25]);
    not BIT26(out[26], A[26]);
    not BIT27(out[27], A[27]);
    not BIT28(out[28], A[28]);
    not BIT29(out[29], A[29]);
    not BIT30(out[30], A[30]);
    not BIT31(out[31], A[31]);
endmodule