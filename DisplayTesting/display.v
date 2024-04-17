module display(JA1, JA2, JA3, JA4, JA7, JA8, JA9, JB1, JB2, JB3, JB4, JB7, JB8, JB9, SW);
    output JA1, JA2, JA3, JA4, JA7, JA8, JA9, JB1, JB2, JB3, JB4, JB7, JB8, JB9;
    input [15:0] SW;

    reg [15:0] msd, lsd;
    reg [6:0] ctrl_msd, ctrl_lsd;

    assign {JA1, JA2, JA3, JA4, JA7, JA8, JA9} = ctrl_msd; // JA1 = A, JA2 = B, ...
    assign {JB1, JB2, JB3, JB4, JB7, JB8, JB9} = ctrl_lsd;

    always begin
        msd = SW/10;
        lsd = SW - msd*10;
        case (msd)
            0 : ctrl_msd = 7'b1111110;
            1 : ctrl_msd = 7'b0110000;
            2 : ctrl_msd = 7'b1101101;
            3 : ctrl_msd = 7'b1111001;
            4 : ctrl_msd = 7'b0110011;
            5 : ctrl_msd = 7'b1011011;
            6 : ctrl_msd = 7'b1011111;
            7 : ctrl_msd = 7'b1110000;
            8 : ctrl_msd = 7'b1111111;
            9 : ctrl_msd = 7'b1110011;
        endcase
        case (lsd)
            0 : ctrl_lsd = 7'b1111110;
            1 : ctrl_lsd = 7'b0110000;
            2 : ctrl_lsd = 7'b1101101;
            3 : ctrl_lsd = 7'b1111001;
            4 : ctrl_lsd = 7'b0110011;
            5 : ctrl_lsd = 7'b1011011;
            6 : ctrl_lsd = 7'b1011111;
            7 : ctrl_lsd = 7'b1110000;
            8 : ctrl_lsd = 7'b1111111;
            9 : ctrl_lsd = 7'b1110011;
        endcase
    end
endmodule