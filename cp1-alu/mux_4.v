module mux_4(out, select, in0, in1, in2, in3);
        
    input [1:0] select;
    input in0, in1, in2, in3;
    output out;
    wire w1, w2;

    mux_2 TOPLEFT(w1, select[0], in0, in1);
    mux_2 BOTTOMLEFT(w2, select[0], in2, in3);
    mux_2 FINAL(out, select[1], w1, w2);
endmodule