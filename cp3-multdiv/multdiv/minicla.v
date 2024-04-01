module minicla(out, A, B, c0);
    input c0;
    input [31:0] A, B;
    output [31:0] out;

    wire [7:0] w0, w1, w2, w3;
    wire P0, G0, P1, G1, P2, G2, P3, G3;
    wire c8, c16, c24, c32, w8_0, w16_0, w16_1, w24_0, w24_1, w24_2, w32_0, w32_1, w32_2, w32_3;
    wire notA_MSB, notB_MSB, notOUT_MSB, ovf1, ovf2;

    eightbit_adder_block B0_7(w0, G0, P0, A[7:0], B[7:0], c0);
    
    and C8T1(w8_0, P0, c0);
    or C8CALC(c8, G0, w8_0);

    eightbit_adder_block B8_15(w1, G1, P1, A[15:8], B[15:8], c8);

    and C16T1(w16_0, P1, P0, c0);
    and C16T2(w16_1, P1, G0);
    or C16CALC(c16, G1, w16_1, w16_0);

    eightbit_adder_block B16_23(w2, G2, P2, A[23:16], B[23:16], c16);

    and C24T1(w24_0, P2, P1, P0, c0);
    and C24T2(w24_1, P2, P1, G0);
    and C24T3(w24_2, P2, G1);
    or C24CALC(c24, G2, w24_2, w24_1, w24_0);

    eightbit_adder_block B24_31(w3, G3, P3, A[31:24], B[31:24], c24);

    and C32T1(w32_0, P3, P2, P1, P0, c0);
    and C32T2(w32_1, P3, P2, P1, G0);
    and C32T3(w32_2, P3, P2, G1);
    and C32T4(w32_3, P3, G2);
    or C32CALC(c32, G3, w32_3, w32_2, w32_1, w32_0);

    assign out = {w3, w2, w1, w0};
endmodule