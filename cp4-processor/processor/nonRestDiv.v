module nonRestDiv(signed_data_out, result_ready, exception, signed_dividend, signed_divisor, clk, newDiv);
    input newDiv, clk; 
    input [31:0] signed_dividend, signed_divisor;
    output result_ready, exception;
    output [31:0] signed_data_out;

    wire [63:0] result_reg_input, result_reg_output, shiftedAQ, sumNewLSB, OpInput;
    wire [31:0] sum_out, dividend, divisor, data_out, notDividend, notDivisor, not_data_out;
    wire [4:0] n_iter;
    wire signMisMatch;

    assign signMisMatch = signed_dividend[31] ^ signed_divisor[31];

    minialu dividentInverter(notDividend, ~signed_dividend, 32'b1, 1'b0);
    minialu divisorInverter(notDivisor, ~signed_divisor, 32'b1, 1'b0);

    assign dividend = signed_dividend[31] ? notDividend : signed_dividend;
    assign divisor = signed_divisor[31] ? notDivisor : signed_divisor;

    assign result_reg_input = newDiv ? {32'b0, dividend} : sumNewLSB;
    
    reg64 AQreg(result_reg_output, result_reg_input, clk, 1'b1, 1'b0);
    
    assign OpInput = newDiv ? result_reg_input : result_reg_output;

    assign shiftedAQ = OpInput << 1;

    minialu divAdder(sum_out, shiftedAQ[63:32], divisor, ~shiftedAQ[63]);

    assign sumNewLSB = {sum_out, shiftedAQ[31:1], ~(sum_out[31])};

    divControlUnit CTRL(n_iter, newDiv, clk);

    assign data_out = result_reg_output[31:0];

    minialu resultInverter(not_data_out, ~data_out, 32'b1, 1'b0);

    assign signed_data_out = signMisMatch ? not_data_out : data_out;

    dffe_ref divReady(result_ready, (n_iter[4] & n_iter[3] & n_iter[2] & n_iter[1] & n_iter[0]), clk, 1'b1, newDiv);

    assign exception = ~(divisor[0] | divisor[1] | divisor[2] | divisor[3] | divisor[4] | divisor[5] | divisor[6] | divisor[7] | divisor[8] | divisor[9] | divisor[10] | divisor[11] | divisor[12] | divisor[13] | divisor[14] | divisor[15] | divisor[16] | divisor[17] | divisor[18] | divisor[19] | divisor[20] | divisor[21] | divisor[22] | divisor[23] | divisor[24] | divisor[25] | divisor[26] | divisor[27] | divisor[28] | divisor[29] | divisor[30] | divisor[31]);
endmodule