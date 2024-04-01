module eightbit_adder_block(out, G, P, A, B, c0);
    input [7:0] A, B;
    input c0;
    output [7:0] out;
    output G, P;

    wire c1, c2, c3, c4, c5, c6, c7;
    wire g0, g1, g2, g3, g4, g5, g6, g7, p0, p1, p2, p3, p4, p5, p6, p7, w1_0, w2_0, w2_1, w3_0, w3_1, w3_2, w4_0, w4_1, w4_2, w4_3, w5_0, w5_1, w5_2, w5_3, w5_4, w6_0, w6_1, w6_2, w6_3, w6_4, w6_5, w7_0, w7_1, w7_2, w7_3, w7_4, w7_5, w7_6, wg0, wg1, wg2, wg3, wg4, wg5, wg6;

    and A0ANDB0(g0, A[0], B[0]);
    and A1ANDB1(g1, A[1], B[1]);
    and A2ANDB2(g2, A[2], B[2]);
    and A3ANDB3(g3, A[3], B[3]);
    and A4ANDB4(g4, A[4], B[4]);
    and A5ANDB5(g5, A[5], B[5]);
    and A6ANDB6(g6, A[6], B[6]);
    and A7ANDB7(g7, A[7], B[7]);

    or A0ORB0(p0, A[0], B[0]);
    or A1ORB1(p1, A[1], B[1]);
    or A2ORB2(p2, A[2], B[2]);
    or A3ORB3(p3, A[3], B[3]);
    or A4ORB4(p4, A[4], B[4]);
    or A5ORB5(p5, A[5], B[5]);
    or A6ORB6(p6, A[6], B[6]);
    or A7ORB7(p7, A[7], B[7]);

    and C1T1(w1_0, p0, c0);
    or C1CALC(c1, g0, w1_0);

    and C2T1(w2_0, p1, p0, c0);
    and C2T2(w2_1, p1, g0);
    or C2CALC(c2, g1, w2_1, w2_0);

    and C3T1(w3_0, p2, p1, p0, c0);
    and C3T2(w3_1, p2, p1, g0);
    and C3T3(w3_2, p2, g1);
    or C3CALC(c3, g2, w3_2, w3_1, w3_0);

    and C4T1(w4_0, p3, p2, p1, p0, c0);
    and C4T2(w4_1, p3, p2, p1, g0);
    and C4T3(w4_2, p3, p2, g1);
    and C4T4(w4_3, p3, g2);
    or C4CALC(c4, g3, w4_3, w4_2, w4_1, w4_0);

    and C5T1(w5_0, p4, p3, p2, p1, p0, c0);
    and C5T2(w5_1, p4, p3, p2, p1, g0);
    and C5T3(w5_2, p4, p3, p2, g1);
    and C5T4(w5_3, p4, p3, g2);
    and C5T5(w5_4, p4, g3);
    or C5CALC(c5, g4, w5_4, w5_3, w5_2, w5_1, w5_0);

    and C6T1(w6_0, p5, p4, p3, p2, p1, p0, c0);
    and C6T2(w6_1, p5, p4, p3, p2, p1, g0);
    and C6T3(w6_2, p5, p4, p3, p2, g1);
    and C6T4(w6_3, p5, p4, p3, g2);
    and C6T5(w6_4, p5, p4, g3);
    and C6T6(w6_5, p5, g4);
    or C6CALC(c6, g5, w6_5, w6_4, w6_3, w6_2, w6_1, w6_0);

    and C7T1(w7_0, p6, p5, p4, p3, p2, p1, p0, c0);
    and C7T2(w7_1, p6, p5, p4, p3, p2, p1, g0);
    and C7T3(w7_2, p6, p5, p4, p3, p2, g1);
    and C7T4(w7_3, p6, p5, p4, p3, g2);
    and C7T5(w7_4, p6, p5, p4, g3);
    and C7T6(w7_5, p6, p5, g4);
    and C7T7(w7_6, p6, g5);
    or C7CALC(c7, g6, w7_6, w7_5, w7_4, w7_3, w7_2, w7_1, w7_0);

    and PCALC(P, p7, p6, p5, p4, p3, p2, p1, p0);

    and WG1(wg0, p7, p6, p5, p4, p3, p2, p1, g0);
    and WG2(wg1, p7, p6, p5, p4, p3, p2, g1);
    and WG3(wg2, p7, p6, p5, p4, p3, g2);
    and WG4(wg3, p7, p6, p5, p4, g3);
    and WG5(wg4, p7, p6, p5, g4);
    and WG6(wg5, p7, p6, g5);
    and WG7(wg6, p7, g6);
    or GCALC(G, g7, wg6, wg5, wg4, wg3, wg2, wg1, wg0);

    adder_cell O0(out[0], A[0], B[0], c0);
    adder_cell O1(out[1], A[1], B[1], c1);
    adder_cell O2(out[2], A[2], B[2], c2);
    adder_cell O3(out[3], A[3], B[3], c3);
    adder_cell O4(out[4], A[4], B[4], c4);
    adder_cell O5(out[5], A[5], B[5], c5);
    adder_cell O6(out[6], A[6], B[6], c6);
    adder_cell O7(out[7], A[7], B[7], c7);
endmodule