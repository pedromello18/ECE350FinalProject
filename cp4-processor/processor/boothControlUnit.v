module boothControlUnit(multiTimesTwo, addOrSub, result_or_zero, count, clk, reset, lowBits);
    input clk, reset;
    input [2:0] lowBits;
    output multiTimesTwo, addOrSub, result_or_zero;
    output [3:0] count;

    assign addOrSub = lowBits[2];
    assign multiTimesTwo = ~(lowBits[1] ^ lowBits[0]);
    assign result_or_zero = ((~lowBits[2]) & (~lowBits[1]) & (~lowBits[0])) | ((lowBits[2]) & (lowBits[1]) & (lowBits[0]));

    counter ITERCOUNTER(count, clk, reset);
endmodule