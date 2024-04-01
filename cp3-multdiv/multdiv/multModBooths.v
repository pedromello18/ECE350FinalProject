module multModBooths(data_out, result_ready, ovf, multiplicand, multiplier, clk, newMult);
    input newMult, clk; 
    input [31:0] multiplicand, multiplier;
    output result_ready, ovf;
    output [31:0] data_out;

    wire [3:0] n_iter;
    wire [2:0] low3bitsAdj;
    wire [31:0] multiplicand_bus, twotimes_multiplicand_bus, sum_input_bus, sum_out_bus, next_high_32_product_reg;
    wire [64:0] result_reg_output, result_reg_input, resetProductReg, shiftedSum, beforeShiftSum;
    wire twotimes_multiplicand_control, add_or_sub_control, result_or_zero, notOvf;

    reg32 MULTIPLICANDREG(multiplicand_bus, multiplicand, newMult, 1'b1, 1'b0);

    assign resetProductReg = {32'b0, multiplier, 1'b0};

    busmux65bit_2 SHIFTEDSUM_OR_MULTIPLIER(result_reg_input, newMult, shiftedSum, resetProductReg);

    reg65 RESULTREG(result_reg_output, result_reg_input, clk, 1'b1, 1'b0);

    lls_1 TWOTIMESMULTIPLICAND(twotimes_multiplicand_bus, 1'b1, multiplicand_bus);

    busmux_2 TWOTIMESMULTIPLICAND_OR_NOT(sum_input_bus, twotimes_multiplicand_control, multiplicand_bus, twotimes_multiplicand_bus);

    minialu BOOTHADDER(sum_out_bus, result_reg_output[64:33], sum_input_bus, add_or_sub_control);

    busmux_2 RESULTORZERO(next_high_32_product_reg, result_or_zero, sum_out_bus, result_reg_output[64:33]);

    assign beforeShiftSum = {next_high_32_product_reg, result_reg_output[32:0]};

    ars_2 SHIFTER(shiftedSum, 1'b1, beforeShiftSum);

    assign low3bitsAdj = newMult ? result_reg_input[2:0] : result_reg_output[2:0];

    boothControlUnit CTRL(twotimes_multiplicand_control, add_or_sub_control, result_or_zero, n_iter, clk, newMult, low3bitsAdj);

    assign data_out = result_reg_output[32:1];

    dffe_ref PRODREADY(result_ready, (n_iter[3] & n_iter[2] & n_iter[1] & n_iter[0]), clk, 1'b1, newMult);

    assign notOvf = (result_reg_output[32] & result_reg_output[33] & result_reg_output[34] & result_reg_output[35] & result_reg_output[36] & result_reg_output[37] & result_reg_output[38] & result_reg_output[39] & result_reg_output[40] & result_reg_output[41] & result_reg_output[42] & result_reg_output[43] & result_reg_output[44] & result_reg_output[45] & result_reg_output[46] & result_reg_output[47] & result_reg_output[48] & result_reg_output[49] & result_reg_output[50] & result_reg_output[51] & result_reg_output[52] & result_reg_output[53] & result_reg_output[54] & result_reg_output[55] & result_reg_output[56] & result_reg_output[57] & result_reg_output[58] & result_reg_output[59] & result_reg_output[60] & result_reg_output[61] & result_reg_output[62] & result_reg_output[63] & result_reg_output[64]) | ~(result_reg_output[32] | result_reg_output[33] | result_reg_output[34] | result_reg_output[35] | result_reg_output[36] | result_reg_output[37] | result_reg_output[38] | result_reg_output[39] | result_reg_output[40] | result_reg_output[41] | result_reg_output[42] | result_reg_output[43] | result_reg_output[44] | result_reg_output[45] | result_reg_output[46] | result_reg_output[47] | result_reg_output[48] | result_reg_output[49] | result_reg_output[50] | result_reg_output[51] | result_reg_output[52] | result_reg_output[53] | result_reg_output[54] | result_reg_output[55] | result_reg_output[56] | result_reg_output[57] | result_reg_output[58] | result_reg_output[59] | result_reg_output[60] | result_reg_output[61] | result_reg_output[62] | result_reg_output[63] | result_reg_output[64]);
    assign ovf = (~notOvf) | (multiplicand[31] & multiplier[31] & result_reg_output[32]);
endmodule