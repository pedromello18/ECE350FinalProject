module bitwise_and(out, A, B);
    input [31:0] A, B;
    output [31:0] out;
    
    and GATE0(out[0], A[0], B[0]);
    and GATE1(out[1], A[1], B[1]);
    and GATE2(out[2], A[2], B[2]);
    and GATE3(out[3], A[3], B[3]);
    and GATE4(out[4], A[4], B[4]);
    and GATE5(out[5], A[5], B[5]);
    and GATE6(out[6], A[6], B[6]);
    and GATE7(out[7], A[7], B[7]);
    and GATE8(out[8], A[8], B[8]);
    and GATE9(out[9], A[9], B[9]);
    and GATE10(out[10], A[10], B[10]);
    and GATE11(out[11], A[11], B[11]);
    and GATE12(out[12], A[12], B[12]);
    and GATE13(out[13], A[13], B[13]);
    and GATE14(out[14], A[14], B[14]);
    and GATE15(out[15], A[15], B[15]);
    and GATE16(out[16], A[16], B[16]);
    and GATE17(out[17], A[17], B[17]);
    and GATE18(out[18], A[18], B[18]);
    and GATE19(out[19], A[19], B[19]);
    and GATE20(out[20], A[20], B[20]);
    and GATE21(out[21], A[21], B[21]);
    and GATE22(out[22], A[22], B[22]);
    and GATE23(out[23], A[23], B[23]);
    and GATE24(out[24], A[24], B[24]);
    and GATE25(out[25], A[25], B[25]);
    and GATE26(out[26], A[26], B[26]);
    and GATE27(out[27], A[27], B[27]);
    and GATE28(out[28], A[28], B[28]);
    and GATE29(out[29], A[29], B[29]);
    and GATE30(out[30], A[30], B[30]);
    and GATE31(out[31], A[31], B[31]);

endmodule