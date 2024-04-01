module single_reg(data_out, data_in, clk, specificWriteEnable, generalWriteEnable, reset);
    input [31:0] data_in;
    input clk, specificWriteEnable, generalWriteEnable, reset;

    output [31:0] data_out;

    wire writeEnable;

    and WE(writeEnable, specificWriteEnable, generalWriteEnable);

    dffe_ref BIT0(data_out[0], data_in[0], clk, writeEnable, reset);
    dffe_ref BIT1(data_out[1], data_in[1], clk, writeEnable, reset);
    dffe_ref BIT2(data_out[2], data_in[2], clk, writeEnable, reset);
    dffe_ref BIT3(data_out[3], data_in[3], clk, writeEnable, reset);
    dffe_ref BIT4(data_out[4], data_in[4], clk, writeEnable, reset);
    dffe_ref BIT5(data_out[5], data_in[5], clk, writeEnable, reset);
    dffe_ref BIT6(data_out[6], data_in[6], clk, writeEnable, reset);
    dffe_ref BIT7(data_out[7], data_in[7], clk, writeEnable, reset);
    dffe_ref BIT8(data_out[8], data_in[8], clk, writeEnable, reset);
    dffe_ref BIT9(data_out[9], data_in[9], clk, writeEnable, reset);
    dffe_ref BIT10(data_out[10], data_in[10], clk, writeEnable, reset);
    dffe_ref BIT11(data_out[11], data_in[11], clk, writeEnable, reset);
    dffe_ref BIT12(data_out[12], data_in[12], clk, writeEnable, reset);
    dffe_ref BIT13(data_out[13], data_in[13], clk, writeEnable, reset);
    dffe_ref BIT14(data_out[14], data_in[14], clk, writeEnable, reset);
    dffe_ref BIT15(data_out[15], data_in[15], clk, writeEnable, reset);
    dffe_ref BIT16(data_out[16], data_in[16], clk, writeEnable, reset);
    dffe_ref BIT17(data_out[17], data_in[17], clk, writeEnable, reset);
    dffe_ref BIT18(data_out[18], data_in[18], clk, writeEnable, reset);
    dffe_ref BIT19(data_out[19], data_in[19], clk, writeEnable, reset);
    dffe_ref BIT20(data_out[20], data_in[20], clk, writeEnable, reset);
    dffe_ref BIT21(data_out[21], data_in[21], clk, writeEnable, reset);
    dffe_ref BIT22(data_out[22], data_in[22], clk, writeEnable, reset);
    dffe_ref BIT23(data_out[23], data_in[23], clk, writeEnable, reset);
    dffe_ref BIT24(data_out[24], data_in[24], clk, writeEnable, reset);
    dffe_ref BIT25(data_out[25], data_in[25], clk, writeEnable, reset);
    dffe_ref BIT26(data_out[26], data_in[26], clk, writeEnable, reset);
    dffe_ref BIT27(data_out[27], data_in[27], clk, writeEnable, reset);
    dffe_ref BIT28(data_out[28], data_in[28], clk, writeEnable, reset);
    dffe_ref BIT29(data_out[29], data_in[29], clk, writeEnable, reset);
    dffe_ref BIT30(data_out[30], data_in[30], clk, writeEnable, reset);
    dffe_ref BIT31(data_out[31], data_in[31], clk, writeEnable, reset);

endmodule